connection: "google_bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: sales {
  group_label: "Sales"
  sql_always_where: ${created_date} >= '2017-04-01' ;;
   join: sales_item {
    relationship: one_to_many
    sql_on: ${sales.entity_id} = ${sales_item.order_id} ;;
  }
  join: sales_sequence {
    relationship: one_to_one
    sql_on: ${sales.entity_id} = ${sales_sequence.order_id} ;;
  }
  join: sales_utm {
    relationship: one_to_one
    sql_on: ${sales.increment_id} = ${sales_utm.order_id} ;;
  }
  join: last_touch_utm {
    relationship: one_to_one
    sql_on: ${sales.entity_id} = ${last_touch_utm.entity_id} ;;
  }
  join: first_touch_utm {
    relationship: one_to_one
    sql_on: ${sales.entity_id} = ${first_touch_utm.entity_id} ;;
  }
  join: customer {
    relationship: one_to_one
    sql_on: ${sales.customer_id} = ${customer.customer_id} ;;
  }
  join: acquisition_utm {
    relationship: one_to_one
    sql_on: ${sales.customer_id} = ${acquisition_utm.customer_id} AND ${acquisition_utm.customer_id} is not null;;
  }
  join: pet {
    relationship: one_to_one
    sql_on: ${sales_item.pet_id} = ${pet.pet_id} ;;
  }
  join: customer_sales {
    relationship: one_to_one
    sql_on: ${sales.customer_id} = ${customer_sales.customer_id} ;;
  }
  join: sales_group_by_meat {
    relationship: one_to_one
    sql_on: ${sales.entity_id}=${sales_group_by_meat.entity_id} ;;
  }
}

explore: sales_sequence {
  group_label: "Sales"
}
explore: sales_item {
  group_label: "Sales"
  join: pet {
    relationship: one_to_one
    sql_on: ${sales_item.pet_id} = ${pet.pet_id} ;;
  }
  join: sales {
    relationship: many_to_one
    sql_on: ${sales_item.order_id} = ${sales.entity_id} ;;
  }
  join: sales_sequence {
    relationship: many_to_one
    sql_on: ${sales_item.order_id} = ${sales_sequence.order_id} ;;
  }
  join: sales_group_by_meat {
    relationship: many_to_one
    sql_on: ${sales_item.order_id} = ${sales_group_by_meat.entity_id} ;;
  }
  sql_always_where: ${created_date} >= '2017-04-01' ;;
}

explore: customer {
  group_label: "Customer"
  join: pet {
    relationship: one_to_many
    sql_on: ${customer.customer_id} = ${pet.owner_id};;
  }
  join: sales {
    relationship: one_to_many
    sql_on: ${customer.customer_id} = ${sales.customer_id};;
  }
  join: sales_sequence {
    relationship: one_to_one
    sql_on: ${sales.entity_id} = ${sales_sequence.order_id} ;;
  }
  join: customer_sales {
    relationship: one_to_one
    sql_on: ${customer.customer_id} = ${customer_sales.customer_id};;
  }
  join: acquisition_utm {
    relationship: one_to_one
    sql_on: ${customer.customer_id} = ${acquisition_utm.customer_id} AND ${acquisition_utm.customer_id} is not null;;
  }
  join: sales_rfm_accumulative {
    relationship: one_to_one
    sql_on: ${customer.customer_id} = ${sales_rfm_accumulative.customer_id};;
  }
  join: subscription {
    relationship: one_to_many
    sql_on: ${subscription.customer_id} = ${customer.customer_id} ;;
  }
}

explore: pet {
  group_label: "Pet"
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
    type: left_outer
    sql_on: ${pet.pet_id} = ${sales_item.pet_id} ;;
  }
  join: sales {
    relationship: many_to_one
    sql_on: ${sales_item.order_id} = ${sales.entity_id} ;;
  }
  join: sales_sequence {
    relationship: many_to_one
    sql_on: ${sales_item.order_id} = ${sales_sequence.order_id} ;;
  }
}

explore: subscription {
  group_label: "Subscription"
  join: customer {
    relationship: one_to_one
    sql_on: ${subscription.customer_id} = ${customer.customer_id} ;;
  }
  join: quote {
    relationship: one_to_one
    sql_on: ${subscription.quote_id} = ${quote.entity_id} ;;
  }
  join: customer_sales {
    relationship: one_to_one
    sql_on: ${subscription.customer_id} = ${customer_sales.customer_id} ;;
  }
}

explore: sales_rfm {
  group_label: "Sales"
  always_filter: {
    filters: [date_filter: "1 months ago"]
  }
}

explore: sales_rfm_monthly {
  group_label: "Sales"
}

explore: sales_rfm_accumulative {
  group_label: "Sales"
}

explore: funnel_first_visit {
}

explore: daily_kpi_targets {

}

explore: ga_daily_users {
  group_label: "Sessions"
}

explore: online_ad_spending {
  group_label: "Digital Marketing"
}

explore: facebook_ad_spending {
  group_label: "Digital Marketing"
}

explore: google_ad_spending {
  group_label: "Digital Marketing"
}

explore: sessions {
  group_label: "Sessions"
  join: daily_aggregated_kpi {
    relationship: one_to_one
    sql_on: ${sessions.started_date} = ${daily_aggregated_kpi.date_date} ;;
  }
}

explore: sessionized_pages {
  group_label: "Sessions"
}

explore: daily_aggregated_kpi {

}

explore: klaviyo_events {

}

explore: frontline_funnel {

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
