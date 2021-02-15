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
  join: sales_utm {
    relationship: one_to_one
    type: left_outer
    sql_on: ${sales.increment_id} = ${sales_utm.order_id} ;;
  }
  join: customer {
    relationship: one_to_one
    type: left_outer
    sql_on: ${sales.customer_id} = ${customer.customer_id} ;;
  }
}

explore: sales_item {
  join: pet {
    relationship: one_to_one
    type: left_outer
    sql_on: ${sales_item.pet_id} = ${pet.pet_id} ;;
  }
  join: sales {
    relationship: many_to_one
    type: inner
    sql_on: ${sales_item.order_id} = ${sales.entity_id} ;;
  }
}

explore: ga_daily_users {
}

explore: daily_kpi_targets {
}

explore: online_ad_spending {
}

explore: customer {
  join: pet {
    relationship: one_to_many
    type: left_outer
    sql_on: ${customer.customer_id} = ${pet.owner_id};;
  }
  join: sales {
    relationship: one_to_many
    type: inner
    sql_on: ${customer.customer_id} = ${sales.customer_id};;
  }
}

explore: pet {
  join: pet_sequence {
    relationship: one_to_one
    type: left_outer
    sql_on: ${pet.pet_id} = ${pet_sequence.pet_id} ;;
  }
  join: customer {
    relationship: many_to_one
    type: left_outer
    sql_on: ${pet.owner_id} = ${customer.customer_id} ;;
  }
  join: sales_item {
    relationship: one_to_many
    type: inner
    sql_on: ${pet.pet_id} = ${sales_item.order_id} ;;
  }
}

explore: subscription {
  join: customer {
    relationship: one_to_one
    type: inner
    sql_on: ${subscription.customer_id} = ${customer.customer_id} ;;
  }
  join: quote {
    relationship: one_to_one
    type: inner
    sql_on: ${subscription.quote_id} = ${quote.entity_id} ;;
  }
  join: quote_item {
    relationship: one_to_many
    type: inner
    sql_on: ${subscription.quote_id} = ${quote_item.quote_id} ;;
  }
}

explore: sales_rfm_monthly {

}

explore: sales_rfm_accumulative {

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
