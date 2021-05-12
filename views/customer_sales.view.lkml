view: customer_sales {
  derived_table: {
    sql:  SELECT
            customer_id,
            SUM(base_grand_total) AS lifetime_sales,
            MIN(created_at) AS first_order_date
          FROM ${sales.SQL_TABLE_NAME}
          GROUP BY 1
     ;;
  }

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: first_order_date {
    label: "Date of First Order"
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
    sql: ${TABLE}.first_order_date ;;
    convert_tz: no
  }

  dimension: lifetime_sales {
    label: "Lifetime Revenue"
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  measure: total_lifetime_sales {
    label: "Sum Lifetime Revenue"
    type: sum
    sql: ${lifetime_sales} ;;
  }

  measure: avg_lifetime_sales {
    label: "Average Lifetime Revenue"
    type: average
    sql: ${lifetime_sales} ;;
    value_format: "0"
  }
}
