data "helm_repository" "pega" {
  name = "pega"
  url  = "https://scrumteamwhitewalkers.github.io/pega-helm-charts/"
}

data "template_file" "pega-values" {
  template = "${file("${path.module}/pega_values.tpl")}"

  vars = {
    JDBC_URL = "jdbc:postgresql://${module.db.db_instance_endpoint}/${module.db.db_instance_name}"
  }
}

resource "helm_release" "pega-installer" {
  namespace  = "${var.namespace}"
  repository = "${data.helm_repository.pega.metadata.0.name}"
  name       = "${var.namespace}"
  chart      = "${var.namespace}"
  version    = "${var.chart_version}"
  values     = ["${data.template_file.pega-values.rendered}"]
  wait       = true
  timeout    = 7200
}
