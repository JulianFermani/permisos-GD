import { Injectable, NotFoundException } from "@nestjs/common";
import { CreateRoleDto } from "./dto/create-role.dto";
import { UpdateRoleDto } from "./dto/update-role.dto";
import { InjectRepository } from "@nestjs/typeorm";
import { Role } from "./entities/role.entity";
import { In, Repository } from "typeorm";
import { Permission } from "src/permissions/entities/permission.entity";

@Injectable()
export class RolesService {
  constructor(
    @InjectRepository(Role)
    private readonly roleRepository: Repository<Role>,
    @InjectRepository(Permission)
    private readonly permissionRepository: Repository<Permission>,
  ) {}

  async create(createRoleDto: CreateRoleDto) {
    const { permissions, ...rest } = createRoleDto;

    const permissionNames = permissions.map((p) => p.name);

    if (permissionNames.length === 0) {
      throw new NotFoundException("Permissions not found");
    }

    const foundPermissions = await this.permissionRepository.find({
      where: {
        name: In(permissionNames),
      },
    });

    if (foundPermissions.length === 0) {
      throw new NotFoundException("No matching permissions found");
    }

    const foundNames = foundPermissions.map((p) => p.name);
    const missingPermissions = permissionNames.filter(
      (name) => !foundNames.includes(name),
    );
    if (missingPermissions.length > 0) {
      throw new NotFoundException(
        `Permissions not found: ${missingPermissions.join(", ")}`,
      );
    }

    const role = this.roleRepository.create({
      ...rest,
      permissions: foundPermissions,
    });

    return this.roleRepository.save(role);
  }

  findAll() {
    return `This action returns all roles`;
  }

  findOne(id: number) {
    return `This action returns a #${id} role`;
  }

  update(id: number, updateRoleDto: UpdateRoleDto) {
    return `This action updates a #${id} role`;
  }

  remove(id: number) {
    return `This action removes a #${id} role`;
  }
}
