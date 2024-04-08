/*
  Warnings:

  - Added the required column `updated_at` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- CreateTable
CREATE TABLE "User_Profile" (
    "id" SERIAL NOT NULL,
    "first_name" TEXT NOT NULL,
    "middle_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "dob" TIMESTAMP(3) NOT NULL,
    "age" INTEGER NOT NULL,
    "contact_number" BIGINT NOT NULL,
    "address_1" TEXT NOT NULL,
    "address_2" TEXT,
    "city" TEXT NOT NULL,
    "height" DECIMAL(65,30) NOT NULL,
    "weight" INTEGER,
    "color" TEXT NOT NULL,
    "religion" TEXT NOT NULL,
    "cast_or_community" TEXT NOT NULL,
    "mother_tongue" TEXT NOT NULL,
    "marital_status" TEXT NOT NULL,
    "dietary_preference" TEXT NOT NULL,
    "occupation" TEXT NOT NULL,
    "income" DECIMAL(65,30) NOT NULL,
    "father_name" TEXT NOT NULL,
    "mother_name" TEXT NOT NULL,
    "mother_occupation" TEXT NOT NULL,
    "father_occupation" TEXT NOT NULL,
    "mother_native" TEXT NOT NULL,
    "father_native" TEXT NOT NULL,
    "family_contact_no" BIGINT NOT NULL,
    "number_of_siblings" INTEGER NOT NULL,
    "brother" INTEGER NOT NULL DEFAULT 0,
    "sister" INTEGER NOT NULL DEFAULT 0,
    "father" BOOLEAN DEFAULT false,
    "mother" BOOLEAN DEFAULT false,
    "zodiac_sign" TEXT NOT NULL,
    "birth_time" TEXT NOT NULL,
    "birth_place" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "horoscope_img" TEXT[],
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "User_Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Liked_Profiles" (
    "id" SERIAL NOT NULL,
    "userProfileIdById" INTEGER NOT NULL,
    "likedToId" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Liked_Profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Download_Profiles" (
    "id" BIGSERIAL NOT NULL,
    "downloadProfileId" INTEGER NOT NULL,
    "downloadToId" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Download_Profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Plans" (
    "id" SERIAL NOT NULL,
    "plan_name" TEXT NOT NULL,
    "plan_desc1" TEXT NOT NULL,
    "plan_desc2" TEXT NOT NULL,
    "plan_desc3" TEXT,
    "plan_price" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Plans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Active_Plan" (
    "id" SERIAL NOT NULL,
    "activeUserId" INTEGER NOT NULL,
    "activePlanId" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "member_disply_limit" INTEGER NOT NULL DEFAULT 0,
    "viwed_profile" INTEGER NOT NULL DEFAULT 0,
    "remaining" INTEGER NOT NULL DEFAULT 0,
    "valid_until" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Active_Plan_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_Profile_contact_number_key" ON "User_Profile"("contact_number");

-- CreateIndex
CREATE UNIQUE INDEX "User_Profile_family_contact_no_key" ON "User_Profile"("family_contact_no");

-- CreateIndex
CREATE UNIQUE INDEX "User_Profile_userId_key" ON "User_Profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Liked_Profiles_userProfileIdById_key" ON "Liked_Profiles"("userProfileIdById");

-- CreateIndex
CREATE UNIQUE INDEX "Liked_Profiles_likedToId_key" ON "Liked_Profiles"("likedToId");

-- CreateIndex
CREATE UNIQUE INDEX "Download_Profiles_downloadProfileId_key" ON "Download_Profiles"("downloadProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "Download_Profiles_downloadToId_key" ON "Download_Profiles"("downloadToId");

-- CreateIndex
CREATE UNIQUE INDEX "Active_Plan_activeUserId_key" ON "Active_Plan"("activeUserId");

-- CreateIndex
CREATE UNIQUE INDEX "Active_Plan_activePlanId_key" ON "Active_Plan"("activePlanId");

-- AddForeignKey
ALTER TABLE "User_Profile" ADD CONSTRAINT "User_Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Liked_Profiles" ADD CONSTRAINT "Liked_Profiles_userProfileIdById_fkey" FOREIGN KEY ("userProfileIdById") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Liked_Profiles" ADD CONSTRAINT "Liked_Profiles_likedToId_fkey" FOREIGN KEY ("likedToId") REFERENCES "User_Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Download_Profiles" ADD CONSTRAINT "Download_Profiles_downloadProfileId_fkey" FOREIGN KEY ("downloadProfileId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Download_Profiles" ADD CONSTRAINT "Download_Profiles_downloadToId_fkey" FOREIGN KEY ("downloadToId") REFERENCES "User_Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Active_Plan" ADD CONSTRAINT "Active_Plan_activeUserId_fkey" FOREIGN KEY ("activeUserId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Active_Plan" ADD CONSTRAINT "Active_Plan_activePlanId_fkey" FOREIGN KEY ("activePlanId") REFERENCES "Plans"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
