view: daily_aggregated_kpi {
  derived_table: {
    persist_for: "1 hour"
    sql:
      WITH pet as (SELECT
        TIMESTAMP(DATE(completed_at)) as date,
        count(pet_id) as count_pet,
        count(CASE WHEN pet_sequence = 1 THEN pet_id ELSE null END) as count_first_pet,
        count(CASE WHEN pet_sequence > 1 THEN pet_id ELSE null END) as count_repeat_pet
      FROM pet_sequence as pet
      GROUP BY 1),
      orders as (SELECT
        TIMESTAMP(DATE(created_at)) as date,
        count(order_id) as count_order,
        count(CASE WHEN order_sequence = 1 THEN order_id ELSE null END) as count_first_order,
        count(CASE WHEN order_sequence > 1 THEN order_id ELSE null END) as count_repeat_order
      FROM sales_sequence as orders
      GROUP BY 1),
      ad_spending as (SELECT
        TIMESTAMP(DATE(date)) as date,
        min(total) as total_spending,
        min(facebook) as facebook_spending,
        min(google) as google_spending,
        min(yahoo) as yahoo_spending,
        min(line) as line_spending
      FROM online_ad_spending as ad_spending
      GROUP BY 1),
      daily_target as (SELECT
        TIMESTAMP(DATE(date)) as date,
        min(ad_spending) as ad_spending_target,
        min(first_order_count) as first_order_count_target,
        min(first_order_sales) as first_order_sales_target,
        min(repeat_order_count) as repeat_order_count_target,
        min(repeat_order_sales) as repeat_order_sales_target,
        min(total_order_count) as total_order_count_target,
        min(total_order_sales) as total_order_sales_target,
        min(karte) as karte_target,
        min(new_user) as new_user_target
      FROM daily_kpi_targets as daily_target
      GROUP BY 1)
      SELECT
        TIMESTAMP(date) as date,
        count_pet, count_first_pet, count_repeat_pet,
        count_order, count_first_order, count_repeat_order,
        total_spending, facebook_spending, google_spending, yahoo_spending, line_spending,
        ad_spending_target, first_order_count_target, first_order_sales_target,
        repeat_order_count_target, repeat_order_sales_target, total_order_count_target,
        total_order_sales_target, karte_target, new_user_target
      FROM UNNEST(GENERATE_DATE_ARRAY('2017-01-01', CURRENT_DATE("Asia/Tokyo"))) AS date
      LEFT JOIN pet on TIMESTAMP(date) = pet.date
      LEFT JOIN orders on TIMESTAMP(date) = orders.date
      LEFT JOIN ad_spending on TIMESTAMP(date) = ad_spending.date
      LEFT JOIN daily_target on TIMESTAMP(date) = daily_target.date
      ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
    convert_tz: no
  }

  measure: count_pet {
    type: min
    sql: ${TABLE}.count_pet ;;
  }

  measure: count_first_pet {
    type: min
    sql: ${TABLE}.count_first_pet ;;
  }

  measure: count_repeat_pet {
    type: min
    sql: ${TABLE}.count_repeat_pet ;;
  }

  measure: count_order {
    type: min
    sql: ${TABLE}.count_order ;;
  }

  measure: count_first_order {
    type: min
    sql: ${TABLE}.count_first_order ;;
  }

  measure: count_repeat_order {
    type: min
    sql: ${TABLE}.count_repeat_order ;;
  }

  measure: total_spending {
    type: min
    sql: ${TABLE}.total_spending ;;
  }

  measure: facebook_spending {
    type: min
    sql: ${TABLE}.facebook_spending ;;
  }

  measure: google_spending {
    type: min
    sql: ${TABLE}.google_spending ;;
  }

  measure: yahoo_spending {
    type: min
    sql: ${TABLE}.yahoo_spending ;;
  }

  measure: line_spending {
    type: min
    sql: ${TABLE}.line_spending ;;
  }

  measure: ad_spending_target {
    type: min
    sql: ${TABLE}.ad_spending_target ;;
  }

  measure: first_order_count_target {
    type: min
    sql: ${TABLE}.first_order_count_target ;;
  }

  measure: first_order_sales_target {
    type: min
    sql: ${TABLE}.first_order_sales_target ;;
  }

  measure: repeat_order_count_target {
    type: min
    sql: ${TABLE}.repeat_order_count_target ;;
  }

  measure: repeat_order_sales_target {
    type: min
    sql: ${TABLE}.repeat_order_sales_target ;;
  }

  measure: total_order_count_target {
    type: min
    sql: ${TABLE}.total_order_count_target ;;
  }

  measure: total_order_sales_target {
    type: min
    sql: ${TABLE}.total_order_sales_target ;;
  }

  measure: karte_target {
    type: min
    sql: ${TABLE}.karte_target ;;
  }

  measure: new_user_target {
    type: min
    sql: ${TABLE}.new_user_target ;;
  }
}
