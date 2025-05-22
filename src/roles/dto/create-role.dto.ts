import { Type } from "class-transformer";
import { IsArray, IsString, ValidateNested } from "class-validator";
import { IdOnlyPermissionDto } from "src/permissions/dto/id-only-dto.dto";

export class CreateRoleDto {
  @IsString()
  code: string;

  @IsString()
  name: string;

  @IsString()
  description: string;

  @ValidateNested({ each: true })
  @Type(() => IdOnlyPermissionDto)
  @IsArray()
  permissions: IdOnlyPermissionDto[];
}
