import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from "@nestjs/common";
import { Reflector } from "@nestjs/core";
import { RequestWithUser } from "src/interfaces/request-user";
import { JwtService } from "src/jwt/jwt.service";
import { UsersService } from "src/users/users.service";
import { Permissions } from "./decorators/permissions.decorator";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Role } from "src/roles/entities/role.entity";
import { UserEntity } from "src/users/entities/user.entity";

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private jwtService: JwtService,
    private usersService: UsersService,
    private reflector: Reflector,
    @InjectRepository(Role)
    private roleRepository: Repository<Role>,
    @InjectRepository(UserEntity)
    private userRepository: Repository<UserEntity>,
  ) {}
  async canActivate(context: ExecutionContext): Promise<boolean> {
    try {
      const request: RequestWithUser = context.switchToHttp().getRequest();
      const token = request.headers.authorization.replace("Bearer ", "");
      if (token == null) {
        throw new UnauthorizedException("El token no existe");
      }
      const payload = this.jwtService.getPayload(token);
      const user = await this.usersService.findByEmail(payload.email);
      request.user = user;
      const permissions = this.reflector.get(Permissions, context.getHandler());

      const userFound = await this.userRepository.findOneBy({ id: user.id });
      const userPermissions = await this.roleRepository.findOne({
        where: { id: userFound.id },
        relations: ["permissions"],
      });

      const permissionsStrings: string[] = [];
      userPermissions.permissions.forEach((permission) =>
        permissionsStrings.push(permission.name),
      );
      const finalPermissions = [];
      for (let i = 0; i < permissions.length; i++) {
        if (permissionsStrings.includes(permissions[i])) {
          finalPermissions.push(1);
        } else {
          finalPermissions.push(0);
        }
      }

      let flag = 0;
      finalPermissions.forEach((permission) =>
        permission === 0 ? (flag = 1) : (flag = 0),
      );
      if (flag === 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw new UnauthorizedException(error?.message);
    }
  }
}
