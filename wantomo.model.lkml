connection: "google_bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: sales {
   join: sales_item {
    relationship: one_to_many
    type: inner
    sql_on: ${sales.entity_id} = ${sales_item.order_id} ;;
  }
  join: sales_sequence {
    relationship: one_to_one
    type: left_outer
    sql_on: ${sales.entity_id} = ${sales_sequence.order_id} ;;
  }
  join: ga_daily_users {
    relationship: one_to_one
    type: left_outer
    sql_on: ${sales.created_date} = ${ga_daily_users.date_date} ;;
  }
}

explore: ga_daily_users {
}

explore: daily_kpi_targets {
}

explore: online_ad_spending {
}

explore: pet {
  join: pet_sequence {
    relationship: one_to_one
    type: left_outer
    sql_on: ${pet.pet_id} = ${pet_sequence.pet_id} ;;
  }
}

explore: sales_rfm_monthly {

}

explore: sales_rfm_accumulative{

}
# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
