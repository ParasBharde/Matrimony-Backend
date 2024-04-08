/*
  Warnings:

  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `User_Profile` table. All the data in the column will be lost.
  - Added the required column `profile_image` to the `User_Profile` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" DROP COLUMN "name";

-- AlterTable
ALTER TABLE "User_Profile" DROP COLUMN "image",
ADD COLUMN     "profile_image" TEXT NOT NULL;
