resource "aws_vpc" "main" {
  cidr_block = "var.vpc_main_cidr"
}

resource "aws_vpc" "dmz" {
  cidr_block = "var.vpc_dmz_cidr"
}

// output "main_vpc_id" {
//   value = "${aws_vpc.main.id}"
// }

// output "dmz_vpc_id" {
//   value = "${aws_vpc.dmz.id}"
// }