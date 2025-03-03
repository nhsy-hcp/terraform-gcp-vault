module "common" {
  source = "./modules/common"

  project_id = var.project_id
  region     = var.region
}
