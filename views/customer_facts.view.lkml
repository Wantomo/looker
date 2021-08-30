view: customer_facts {
  sql_table_name: `leafy-habitat-174801.dataform_bi.customer_facts`
    ;;

  dimension: average_date_diff {
    type: number
    sql: ${TABLE}.average_date_diff ;;
  }

  dimension: average_date_diff_day_tier {
    type: tier
    tiers: [0,7,14,21,28,35,42,49,56]
    style: integer
    sql: ${average_date_diff} ;;
  }

  dimension: customer_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.customer_id ;;
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

  dimension: lifetime_sales {
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  dimension: order_count {
    type: number
    sql: ${TABLE}.order_count ;;
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
    drill_fields: []
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
}
