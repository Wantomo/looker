connection: "google_bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

datagroup: klaviyo_datagroup {
  sql_trigger: SELECT max(timestamp) FROM `leafy-habitat-174801.dataform_klaviyo.events` ;;
  max_cache_age: "24 hours"
  description: "Triggered when new Klaviyo emails arrived"
}
datagroup: segment_datagroup {
  sql_trigger: SELECT max(timestamp) FROM `leafy-habitat-174801.dataform_segment.sessionized_pages` ;;
  max_cache_age: "24 hours"
  description: "Triggered when new Segment data arrived"
}

access_grant: access_grant_full {
  user_attribute: access_type
  allowed_values: [ "full"]
}

explore: sales {
  group_label: "Sales"
  sql_always_where: ${sales.created_date} >= '2017-04-01' AND ${sales.status} IN ('processing','pending','complete','shipped');;
   join: sales_item {
    relationship: one_to_many
    sql_on: ${sales.entity_id} = ${sales_item.order_id} ;;
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
  join: customer_sales {
    relationship: one_to_one
    sql_on: ${customer.customer_id} = ${customer_sales.customer_id};;
  }
  join: acquisition_utm {
    relationship: one_to_one
    sql_on: ${customer.customer_id} = ${acquisition_utm.customer_id} AND ${acquisition_utm.customer_id} is not null;;
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

explore: klaviyo_events {
  group_label: "Digital Marketing"
  persist_with: klaviyo_datagroup
  join: last_touch_utm {
    relationship: one_to_one
    sql_on: ${klaviyo_events.utm} = ${last_touch_utm.campaign_name} AND ${klaviyo_events.date_date} = ${last_touch_utm.order_date_date};;
  }
}

explore: sessions {
  group_label: "Sessions"
  persist_with: segment_datagroup
  join: daily_aggregated_kpi {
    relationship: one_to_one
    sql_on: ${sessions.started_date} = ${daily_aggregated_kpi.date_date} ;;
  }
}

explore: sessionized_pages {
  group_label: "Sessions"
  persist_with: segment_datagroup
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

explore: sales_rfm {
  group_label: "Sales"
  always_filter: {
    filters: [date_filter: "1 months ago"]
  }
  hidden:yes
}

explore: sales_rfm_monthly {
  group_label: "Sales"
  hidden:yes
}

explore: sales_rfm_accumulative {
  group_label: "Sales"
  hidden:yes
}

explore: daily_kpi_targets {
  hidden:yes
}

explore: daily_aggregated_kpi {
  hidden:yes
}

explore: frontline_funnel {
  #required_access_grants: [access_grant_full]
  persist_with: segment_datagroup
  hidden:yes
}

explore: food_funnel {
  #required_access_grants: [access_grant_full]
  persist_with: segment_datagroup
  hidden:yes
}

explore: funnel_first_visit {
  #required_access_grants: [access_grant_full]
  hidden:yes
}
