view: sales_rfm_monthly {
  drill_fields: [order_detail*]
  derived_table: {
    # Built for monthly RFM analysis. Only includes orders for the month (R0 = current month)
    # Grouped by customer_id (= distinct). If multiple orders are made same month, MAX segment is used
    sql:  SELECT
            customer_id,
            date,
            count(order_id) as count_order,
            SUM(base_grand_total) as total,
            MAX(customer_segment) as customer_segment,
            MAX(recency) AS order_recency,
            -- For churn rate : following month for F1/F2, 2 months after from F3
            CASE
                WHEN MAX(customer_segment) = '1-First Order' AND (MAX(recency) > 1 OR MAX(recency) IS NULL OR MAX(recency) = 0) THEN TIMESTAMP(DATE_ADD(DATE(date), INTERVAL 1 MONTH))
                WHEN MAX(customer_segment) = '2-First Repeat Order'AND (MAX(recency) > 1 OR MAX(recency) IS NULL OR MAX(recency) = 0) THEN TIMESTAMP(DATE_ADD(DATE(date), INTERVAL 1 MONTH))
                WHEN MAX(customer_segment) = '3-Repeater' AND (MAX(recency) > 2 OR MAX(recency) IS NULL OR MAX(recency) = 0) THEN TIMESTAMP(DATE_ADD(DATE(date), INTERVAL 2 MONTH))
                WHEN MAX(customer_segment) = '4-Loyal' AND (MAX(recency) > 2 OR MAX(recency) IS NULL OR MAX(recency) = 0) THEN TIMESTAMP(DATE_ADD(DATE(date), INTERVAL 2 MONTH))
            END AS potential_churn_date,
            -- For accumulative : add following month (from F3)
            CASE
                WHEN MAX(customer_segment) = '3-Repeater' AND (MAX(recency) >= 2 OR MAX(recency) IS NULL) THEN TIMESTAMP(DATE_ADD(DATE(date), INTERVAL 1 MONTH))
                WHEN MAX(customer_segment) = '4-Loyal' AND (MAX(recency) >= 2 OR MAX(recency) IS NULL) THEN TIMESTAMP(DATE_ADD(DATE(date), INTERVAL 1 MONTH))
            END AS R2,
            MAX(order_sequence) as order_sequence
          FROM (
            SELECT
              customer_id,
              TIMESTAMP_TRUNC(created_at, MONTH) as date,
              increment_id as order_id,
              base_grand_total,
              CASE
                WHEN order_sequence = 1 THEN '1-First Order'
                WHEN order_sequence = 2 THEN '2-First Repeat Order'
                WHEN order_sequence BETWEEN 3 AND 4 THEN '3-Repeater'
                WHEN order_sequence > 4 THEN '4-Loyal'
              END as customer_segment,
              DATE_DIFF(DATE(LAG(DATETIME(created_at)) OVER (PARTITION BY customer_id ORDER BY entity_id DESC)), DATE(DATETIME(created_at)), MONTH) AS recency,
              order_sequence
              FROM ${sales.SQL_TABLE_NAME}
              WHERE order_type = 1 AND customer_id is not null AND
            status IN ('processing','pending','complete','shipped')
          )
          GROUP BY 1, 2
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

  dimension: order_recency {
    description: "order_recency"
    type: number
    sql: ${TABLE}.order_recency ;;
  }

  dimension: order_sequence {
    description: "Sequence of order per customer"
    type: number
    sql: ${TABLE}.order_sequence ;;
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

  set: order_detail {
    fields: [customer_id, date_month, order_sequence]
  }
}
