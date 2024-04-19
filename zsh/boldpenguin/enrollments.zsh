###############################################################################
# BP - Enrollment Functions
# deactivate_bc => Deactivates brokerage from businesscoverage
# deactivate_enrollments => Deactivates brokerage from from subdomain
###############################################################################

deactivate_bc() {
  AUTH && rake 'enrollments:deactivate_all_for_brokerage[businesscoverage]'
}

deactivate_enrollments() {
  AUTH && rake "enrollments:deactivate_all_for_brokerage[$1]" && PE && echo "Deactivated all enrollments for $1"
}