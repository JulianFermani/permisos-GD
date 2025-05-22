import { IsOptional, IsString, ValidateNested } from "class-validator";
import { Type } from "class-transformer";
import { IdOnlyRolDto } from "src/roles/dto/id-only-dto.dto";

export class UpdatePermissionDto {
  @IsOptional()
  @IsString()
  name: string;

  @IsOptional()
  @IsString()
  description: string;

  @IsOptional()
  @ValidateNested()
  @Type(() => IdOnlyRolDto)
  id_rol: IdOnlyRolDto[];
}
