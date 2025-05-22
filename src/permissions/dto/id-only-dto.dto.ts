import { IsString } from "class-validator";

export class IdOnlyPermissionDto {
  @IsString()
  name: string;
}
