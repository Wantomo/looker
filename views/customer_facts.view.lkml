view: customer_facts {
  sql_table_name: `leafy-habitat-174801.dataform_bi.customer_facts`
    ;;

  dimension: average_date_diff {
    type: number
    sql: ${TABLE}.average_date_diff ;;
    value_format: "0"
  }

  dimension: average_date_diff_day_tier {
    type: tier
    tiers: [0,7,14,21,28,35,42,49,56]
    style: integer
    sql: ${average_date_diff} ;;
  }

  dimension: months_since_registration {
    type: number
    sql: ${TABLE}.months_since_registration ;;
  }

  dimension: avg_monthly_orders_since_registration {
    type: number
    sql: ${TABLE}.avg_monthly_orders_since_registration ;;
  }

  dimension_group: churn {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.churn_date ;;
    convert_tz: no
  }

  dimension: churn_group {
    type: number
    sql: ${TABLE}.churn_group ;;
  }

  dimension: churn_group_name {
    type: string
    sql:  CASE
            WHEN ${churn_group} = 1 THEN 'Low (+30d)'
            WHEN ${churn_group} = 2 THEN 'Medium (+60d)'
            WHEN ${churn_group} = 3 THEN 'High (+90d)'
            WHEN ${churn_group} = 4 THEN 'Very High (+150d)'
            WHEN ${churn_group} = 5 THEN 'Sayonara (+270d)'
            WHEN ${churn_group} = 0 THEN 'Not churned'
          END;;
  }

  dimension: customer_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: days_btw_subscription_and_first_purchase {
    type: number
    sql: ${TABLE}.days_btw_subscription_and_first_purchase ;;
  }

  dimension: days_btw_subscription_and_first_purchase_tier {
    type: tier
    tiers: [15,30,60,90,120,180]
    style: integer
    sql: ${days_btw_subscription_and_first_purchase} ;;
  }

  dimension: first_order_id {
    type: string
    sql: ${TABLE}.first_order_id ;;
  }

  dimension_group: first_purchase {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_purchase_date ;;
    convert_tz: no
  }

  dimension: first_purchase_date_diff_day {
    type: number
    sql: ${TABLE}.first_purchase_date_diff_day ;;
  }

  dimension: first_purchase_date_diff_hour {
    type: number
    sql: ${TABLE}.first_purchase_date_diff_hour ;;
  }

  dimension: first_purchase_gram_per_pet {
    type: number
    sql: ${TABLE}.first_purchase_gram_per_pet ;;
  }

  dimension: first_purchase_gram_per_pet_tier {
    type: tier
    tiers: [150,800,1600,2400,3200]
    style: integer
    sql: ${first_purchase_gram_per_pet} ;;
  }

  dimension: first_purchase_gram_total {
    type: number
    sql: ${TABLE}.first_purchase_gram_total ;;
  }

  dimension: first_purchase_has_discount {
    type: yesno
    sql: ${TABLE}.first_purchase_has_discount = 1 ;;
  }

  dimension: first_purchase_is_subscription {
    type: yesno
    sql: ${TABLE}.first_purchase_is_subscription = 1 ;;
  }

  dimension: first_purchase_meat {
    type: string
    sql: ${TABLE}.first_purchase_meat ;;
  }

  dimension: first_purchase_pet_count {
    type: number
    sql: ${TABLE}.first_purchase_pet_count ;;
  }

  dimension: first_purchase_product {
    type: string
    sql: ${TABLE}.first_purchase_product ;;
  }

  dimension_group: first_subscription {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.first_subscription_date ;;
    convert_tz: no
  }

  dimension: first_subscription_sequence {
    type: number
    sql: ${TABLE}.first_subscription_sequence ;;
  }

  dimension: first_subscription_sequence_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${first_subscription_sequence} ;;
  }

  dimension: last_order_id {
    type: string
    sql: ${TABLE}.last_order_id ;;
  }

  dimension_group: last_purchase {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_purchase_date ;;
    convert_tz: no
  }

  dimension_group: last_purchase_date_diff_day {
    type: duration
    intervals: [day]
    sql_start: ${last_purchase_date} ;;
    sql_end: CURRENT_DATE("Asia/Tokyo");;
  }

  dimension: last_purchase_date_diff_delta_with_average {
    type: number
    sql: ${days_last_purchase_date_diff_day} - ${average_date_diff};;
    value_format: "0"
  }

  dimension: last_purchase_date_diff_delta_with_average_tier {
    type: tier
    tiers: [0,7,14,21,28,35,42,49,56]
    style: integer
    sql: ${last_purchase_date_diff_delta_with_average} ;;
  }

  dimension: last_purchase_gram_per_pet {
    type: number
    sql: ${TABLE}.last_purchase_gram_per_pet ;;
  }

  dimension: last_purchase_gram_per_pet_tier {
    type: tier
    tiers: [150,800,1600,2400,3200]
    style: integer
    sql: ${last_purchase_gram_per_pet} ;;
  }

  dimension: last_purchase_gram_total {
    type: number
    sql: ${TABLE}.last_purchase_gram_total ;;
  }

  dimension: last_purchase_is_subscription {
    type: yesno
    sql: ${TABLE}.last_purchase_is_subscription = 1 ;;
  }

  dimension: last_purchase_meat {
    type: string
    sql: ${TABLE}.last_purchase_meat ;;
  }

  dimension: last_purchase_pet_count {
    type: number
    sql: ${TABLE}.last_purchase_pet_count ;;
  }

  dimension: last_purchase_product {
    type: string
    sql: ${TABLE}.last_purchase_product ;;
  }

  dimension_group: last_regular {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_regular_date ;;
    convert_tz: no
  }

  dimension: last_regular_sequence {
    type: number
    sql: ${TABLE}.last_regular_sequence ;;
  }

  dimension_group: last_subscription {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_subscription_date ;;
    convert_tz: no
  }

  dimension: last_subscription_sequence {
    type: number
    sql: ${TABLE}.last_subscription_sequence ;;
  }

  dimension: lifetime_sales {
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  dimension: lifetime_sales_tier {
    type: tier
    tiers: [1,10000,50000,100000]
    style: integer
    sql: ${lifetime_sales} ;;
  }

  dimension: lifetime_sales_3M {
    type: number
    sql: ${TABLE}.lifetime_sales_3M ;;
  }

  dimension: lifetime_sales_6M {
    type: number
    sql: ${TABLE}.lifetime_sales_6M ;;
  }

  dimension: lifetime_sales_12M {
    type: number
    sql: ${TABLE}.lifetime_sales_12M ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: order_count_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${order_count} ;;
  }

  dimension: order_count_subscription {
    type: number
    sql: ${TABLE}.order_count_subscription ;;
  }

  dimension: order_count_subscription_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${order_count_subscription} ;;
  }

  dimension: second_order_id {
    type: string
    sql: ${TABLE}.second_order_id ;;
  }

  dimension_group: second_purchase {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.second_purchase_date ;;
    convert_tz: no
  }

  dimension: second_purchase_date_diff_day {
    type: number
    sql: ${TABLE}.second_purchase_date_diff_day ;;
  }

  dimension: second_purchase_date_diff_day_tier {
    type: tier
    tiers: [0,7,14,21,28,35,42,49,56]
    style: integer
    sql: ${second_purchase_date_diff_day} ;;
  }

  dimension: second_purchase_gram_per_pet {
    type: number
    sql: ${TABLE}.second_purchase_gram_per_pet ;;
  }

  dimension: second_purchase_gram_per_pet_tier {
    type: tier
    tiers: [150,800,1600,2400,3200]
    style: integer
    sql: ${second_purchase_gram_per_pet} ;;
  }

  dimension: second_purchase_gram_total {
    type: number
    sql: ${TABLE}.second_purchase_gram_total ;;
  }

  dimension: second_purchase_has_discount {
    type: yesno
    sql: ${TABLE}.second_purchase_has_discount = 1 ;;
  }

  dimension: second_purchase_is_subscription {
    type: yesno
    sql: ${TABLE}.second_purchase_is_subscription = 1 ;;
  }

  dimension: second_purchase_meat {
    type: string
    sql: ${TABLE}.second_purchase_meat ;;
  }

  dimension: second_purchase_pet_count {
    type: number
    sql: ${TABLE}.second_purchase_pet_count ;;
  }

  dimension: second_purchase_product {
    type: string
    sql: ${TABLE}.second_purchase_product ;;
  }

  dimension: switch_from_sub_to_regular {
    type: yesno
    sql: ${TABLE}.switch_from_sub_to_regular = 1 ;;
  }

  dimension: third_order_id {
    type: string
    sql: ${TABLE}.third_order_id ;;
  }

  dimension_group: third_purchase {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.third_purchase_date ;;
    convert_tz: no
  }

  dimension: third_purchase_date_diff_day {
    type: number
    sql: ${TABLE}.third_purchase_date_diff_day ;;
  }

  dimension: third_purchase_date_diff_day_tier {
    type: tier
    tiers: [0,7,14,21,28,35,42,49,56]
    style: integer
    sql: ${third_purchase_date_diff_day} ;;
  }

  dimension: third_purchase_gram_per_pet {
    type: number
    sql: ${TABLE}.third_purchase_gram_per_pet ;;
  }

  dimension: third_purchase_gram_per_pet_tier {
    type: tier
    tiers: [150,800,1600,2400,3200]
    style: integer
    sql: ${third_purchase_gram_per_pet} ;;
  }

  dimension: third_purchase_gram_total {
    type: number
    sql: ${TABLE}.third_purchase_gram_total ;;
  }

  dimension: third_purchase_is_subscription {
    type: yesno
    sql: ${TABLE}.third_purchase_is_subscription = 1 ;;
  }

  dimension: third_purchase_meat {
    type: string
    sql: ${TABLE}.third_purchase_meat ;;
  }

  dimension: third_purchase_pet_count {
    type: number
    sql: ${TABLE}.third_purchase_pet_count ;;
  }

  dimension: third_purchase_product {
    type: string
    sql: ${TABLE}.third_purchase_product ;;
  }

  measure: count {
    type: count
    drill_fields: [customer_id]
  }

  measure: avg_first_purchase_date_diff {
    type: average
    sql: ${first_purchase_date_diff_day} ;;
    value_format: "0"
  }

  measure: mdn_first_purchase_date_diff {
    type: median
    sql: ${first_purchase_date_diff_day} ;;
    value_format: "0"
  }

  measure: avg_second_purchase_date_diff {
    type: average
    sql: ${second_purchase_date_diff_day} ;;
    value_format: "0"
  }

  measure: mdn_second_purchase_date_diff {
    type: median
    sql: ${second_purchase_date_diff_day} ;;
    value_format: "0"
  }

  measure: avg_third_purchase_date_diff {
    type: average
    sql: ${third_purchase_date_diff_day} ;;
    value_format: "0"
  }

  measure: mdn_third_purchase_date_diff {
    type: median
    sql: ${third_purchase_date_diff_day} ;;
    value_format: "0"
  }

  measure: mdn_average_date_diff {
    type: median
    sql: ${average_date_diff} ;;
    value_format: "0"
  }

  measure: mdn_first_subscription_sequence {
    type: median
    sql: ${first_subscription_sequence} ;;
    value_format: "0"
  }

  measure: mdn_last_regular_sequence {
    type: median
    sql: ${last_regular_sequence} ;;
    value_format: "0"
  }

  measure: mdn_last_subscription_sequence {
    type: median
    sql: ${last_subscription_sequence} ;;
    value_format: "0"
  }

  measure: total_lifetime_sales {
    type: sum
    sql: ${lifetime_sales} ;;
  }

  measure: total_lifetime_sales_3M {
    type: sum
    sql: ${lifetime_sales_3M} ;;
  }

  measure: total_lifetime_sales_6M {
    type: sum
    sql: ${lifetime_sales_6M} ;;
  }

  measure: total_lifetime_sales_12M {
    type: sum
    sql: ${lifetime_sales_12M} ;;
  }
}
