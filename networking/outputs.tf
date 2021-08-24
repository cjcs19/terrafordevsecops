/*
 _____  __  __  ____  ____  __  __  ____  ___
(  _  )(  )(  )(_  _)(  _ \(  )(  )(_  _)/ __)
 )(_)(  )(__)(   )(   )___/ )(__)(   )(  \__ \
(_____)(______) (__) (__)  (______) (__) (___/

*/

output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnet_pub_a_id" {
  value = aws_subnet.subnet_pub_a.id
}

output "subnet_pub_a_cidr" {
  value = aws_subnet.subnet_pub_a.cidr_block
}
