import { Injectable, UnauthorizedException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { JwtService } from "src/jwt/jwt.service";
import { Role } from "src/roles/entities/role.entity";
import { UserEntity } from "src/users/entities/user.entity";
import { UsersService } from "src/users/users.service";
import { Repository } from "typeorm";

@Injectable()
export class AuthService {
  constructor(
    private jwtService: JwtService,
    private usersService: UsersService, // Asumo que inyectas UsersService aquí para obtener el usuario
  ) {}

  async validateTokenAndPermissions(
    token: string,
    requiredPermissions: string[],
  ): Promise<boolean> {
    try {
      const payload = this.jwtService.getPayload(token, "auth"); // 'auth' para accessToken
      console.log("Payload del token:", payload); // Ver el payload

      const user = await this.usersService.findByEmail(payload.email); // Obtener el usuario
      console.log("Usuario encontrado:", user ? user.email : "No encontrado"); // Confirmar si el usuario existe

      if (!user || !user.rol) {
        // Asegúrate de que el usuario y su rol existen
        console.log("Usuario o rol no encontrado.");
        throw new UnauthorizedException("Invalid user or role information.");
      }

      // Añade estos logs para ver los permisos
      console.log("Rol del usuario:", user.rol.code);
      console.log(
        "Permisos cargados en el rol:",
        user.rol.permissions.map((p) => p.name),
      ); // <-- ¡Este es crucial!
      console.log("Permisos requeridos:", requiredPermissions);

      const userPermissions = user.rol.permissions.map((p) => p.name);
      const hasAllPermissions = requiredPermissions.every((perm) =>
        userPermissions.includes(perm),
      );

      if (!hasAllPermissions) {
        console.log(
          `Faltan permisos. User has: [<span class="math-inline">\{userPermissions\.join\(', '\)\}\], Required\: \[</span>{requiredPermissions.join(', ')}]`,
        );
        throw new UnauthorizedException("Insufficient permissions.");
      }

      return true;
    } catch (error) {
      console.error("Error en validateTokenAndPermissions:", error.message);
      if (error.name === "TokenExpiredError") {
        throw new UnauthorizedException("TokenExpiredError"); // Re-lanzar para que el interceptor lo maneje
      }
      throw new UnauthorizedException(
        "Invalid token or permissions check failed.",
      );
    }
  }
}
