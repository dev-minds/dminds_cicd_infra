resource "aws_vpc" "main" {
  cidr_block = "10.28.0.0/16"
}

resource "aws_vpc" "dmz" {
  cidr_block = "10.29.0.0/16"
}

// output "main_vpc_id" {
//   value = "${aws_vpc.main.id}"
// }

// output "dmz_vpc_id" {
//   value = "${aws_vpc.dmz.id}"
// }