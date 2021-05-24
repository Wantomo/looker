view: customer_sales {
  derived_table: {
    sql:  SELECT
            customer_id,
            SUM(base_grand_total) AS lifetime_sales,
            MIN(created_at) AS first_order_date,
            MAX(created_at) AS last_order_date,
            count(*) AS order_count
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

  dimension_group: last_order_date {
    label: "Date of Last Order"
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
    sql: ${TABLE}.last_order_date ;;
    convert_tz: no
  }

  dimension: lifetime_sales {
    label: "Lifetime Revenue"
    type: number
    sql: ${TABLE}.lifetime_sales ;;
  }

  dimension: order_count {
    label: "Number of Orders"
    type: number
    sql: ${TABLE}.order_count ;;
  }

  dimension: segment {
    label: "Segment"
    description: "Segment of customer based on orders"
    type: string
    sql:  CASE
              WHEN ${order_count} = 1 THEN '1-First Order'
              WHEN ${order_count} = 2 THEN '2-First Repeat'
              WHEN ${order_count} > 2 AND ${order_count} < 5 THEN '3-Repeater'
              WHEN ${order_count} >= 5 THEN '4-Loyal'
              ELSE '0 - No order'
          END ;;
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
