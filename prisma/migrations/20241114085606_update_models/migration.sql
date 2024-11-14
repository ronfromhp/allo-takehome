/*
  Warnings:

  - You are about to drop the `Doctor` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "Doctor";

-- CreateTable
CREATE TABLE "doctors" (
    "doctorCredentialId" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,

    CONSTRAINT "doctors_pkey" PRIMARY KEY ("doctorCredentialId")
);

-- CreateIndex
CREATE UNIQUE INDEX "doctors_email_key" ON "doctors"("email");
