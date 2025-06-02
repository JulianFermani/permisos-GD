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
    return this.roleRepository.find();
  }

  findOne(id: number) {
    return this.roleRepository.findOne({ where: { id } });
  }

  async update(id: number, updateRoleDto: UpdateRoleDto) {
    const role = await this.roleRepository.findOne({
      where: { id },
      relations: ["permission", "user"],
    });
    if (!role) {
      throw new NotFoundException(`This role with ${id} not exist`);
    }
    if (updateRoleDto.name !== undefined) {
      role.name == updateRoleDto.name;
    }
    if (updateRoleDto.description !== undefined) {
      role.description == updateRoleDto.description;
    }
    if (updateRoleDto.permissions) {
      const newPermission = this.permissionRepository.create(
        updateRoleDto.permissions,
      );

      await this.permissionRepository.save(newPermission);
      role.permissions = newPermission;
    }
    return await this.roleRepository.save(role);
  }

  async remove(id: number): Promise<void> {
    const role = await this.roleRepository.findOne({ where: { id } });

    if (!role) {
      throw new NotFoundException(`This role with this ${id} not found`);
    }
    await this.roleRepository.remove(role);
  }
}
