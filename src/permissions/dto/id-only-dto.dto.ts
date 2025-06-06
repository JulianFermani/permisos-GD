import { IsInt } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";

export class IdOnlyPermissionDto {
  @ApiProperty()
  @IsInt()
  id: number;
}
