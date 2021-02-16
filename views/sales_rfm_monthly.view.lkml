view: sales_rfm_monthly {
  #Or, you could make this view a derived table, like this:
  derived_table: {
    sql:  SELECT
              customer_id,
              date_formatted as date,
              count(order_id) as count_order,
              SUM(base_grand_total) as total,
              MAX(customer_segment) as customer_segment,
              MAX(R) AS R,
              CASE
                  WHEN MAX(customer_segment) = '1-First Order' AND (MAX(R) > 1 OR MAX(R) IS NULL OR MAX(R) = 0) THEN TIMESTAMP(DATE_ADD(DATE(date_formatted), INTERVAL 1 MONTH))
                  WHEN MAX(customer_segment) = '2-First Repeat Order'AND (MAX(R) > 1 OR MAX(R) IS NULL OR MAX(R) = 0) THEN TIMESTAMP(DATE_ADD(DATE(date_formatted), INTERVAL 1 MONTH))
                  WHEN MAX(customer_segment) = '3-Repeater' AND (MAX(R) > 2 OR MAX(R) IS NULL OR MAX(R) = 0) THEN TIMESTAMP(DATE_ADD(DATE(date_formatted), INTERVAL 2 MONTH))
                  WHEN MAX(customer_segment) = '4-Loyal' AND (MAX(R) > 2 OR MAX(R) IS NULL OR MAX(R) = 0) THEN TIMESTAMP(DATE_ADD(DATE(date_formatted), INTERVAL 2 MONTH))
              END AS potential_churn_date,
              CASE
                  WHEN MAX(customer_segment) = '3-Repeater' AND (MAX(R) >= 2 OR MAX(R) IS NULL) THEN TIMESTAMP(DATE_ADD(DATE(date_formatted), INTERVAL 1 MONTH))
                  WHEN MAX(customer_segment) = '4-Loyal' AND (MAX(R) >= 2 OR MAX(R) IS NULL) THEN TIMESTAMP(DATE_ADD(DATE(date_formatted), INTERVAL 1 MONTH))
              END AS R2,
              MAX(order_sequence) as order_sequence
          FROM ${sales_sequence.SQL_TABLE_NAME} WHERE customer_id is not null
          group by 1, 2
          ;;
  }

  dimension: customer_id {
    description: "Unique ID for each user"
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
    convert_tz: no
  }

  dimension: count_order {
    type: number
    sql: ${TABLE}.count_order ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  dimension: customer_segment {
    type: string
    sql: ${TABLE}.customer_segment ;;
  }

  measure: count {
    type: count
  }

  measure: sum_total {
    type: sum
    sql: ${total} ;;
  }

  measure: avg_total {
    type: number
    sql: round(avg(${total})) ;;
  }

  measure: sum_count_order {
    type: sum
    sql: ${count_order} ;;
  }
}
