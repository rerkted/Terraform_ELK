# Manage a Route53 hosted zone
resource "aws_route53_zone" "ererkt" {
  name = "rerktserver.com"
}
# Provide a Route53 record resource
resource "aws_route53_record" "elk" {
  zone_id = aws_route53_zone.ererkt.zone_id
  name = "elk.rerktserver.com"
  type = "A"
  ttl = "300"
  records = [aws_eip.ip.public_ip]
}
output "name_server" {
  value = aws_route53_zone.ererkt.name_servers
}
