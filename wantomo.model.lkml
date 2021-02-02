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
