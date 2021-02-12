view: sales_sequence {
    derived_table: {
    sql:  SELECT
              entity_id AS order_id,
              increment_id AS real_order_id,
              customer_id,
              created_at,
              base_grand_total,
              ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS order_sequence,
              CASE
                WHEN ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY entity_id ASC) = 1 THEN '1-First Order'
                WHEN ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY entity_id ASC) = 2 THEN '2-First Repeat Order'
                WHEN ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY entity_id ASC) BETWEEN 3 AND 4 THEN '3-Repeater'
                WHEN ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY entity_id ASC) > 4 THEN '4-Loyal'
              END AS customer_group,
              TIMESTAMP(CONCAT(EXTRACT(YEAR FROM DATETIME(created_at,"Asia/Tokyo")), '-', LPAD(CAST(EXTRACT(MONTH FROM DATETIME(created_at,"Asia/Tokyo")) AS STRING),2,'0'), '-','01')) as date_formatted,
              DATE_DIFF(DATE(LAG(DATETIME(created_at,"Asia/Tokyo")) OVER (PARTITION BY customer_id ORDER BY entity_id DESC)), DATE(DATETIME(created_at,"Asia/Tokyo")), MONTH) AS R,
              TIMESTAMP(CONCAT(EXTRACT(YEAR FROM DATE(LAG(DATETIME(created_at,"Asia/Tokyo")) OVER (PARTITION BY customer_id ORDER BY entity_id DESC))), '-', LPAD(CAST(EXTRACT(MONTH FROM DATE(LAG(DATETIME(created_at,"Asia/Tokyo")) OVER (PARTITION BY customer_id ORDER BY entity_id DESC))) AS STRING),2,'0'), '-','01')) as next_order_date_formatted
          FROM sales
          WHERE status IN ('processing', 'pending', 'complete', 'shipped') and customer_id is not null
     ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: customer_id {
    description: "Unique ID for each user"
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: order_id {
    description: "Unique ID for each order"
    type: number
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: real_order_id {
    description: "Real order ID for each order"
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_sequence {
    description: "Sequence of order per customer"
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  dimension: customer_group {
    description: "Customer group"
    type: string
    sql: ${TABLE}.customer_group ;;
  }

  dimension: base_grand_total {
    type: number
    sql: ${TABLE}.base_grand_total ;;
  }

  measure: count {
    label: "Count"
    type: count
  }

  measure: count_distinct {
    type: count_distinct
    sql: ${customer_id} ;;
  }

  measure: max_customer_group {
    type: string
    sql: MAX(${customer_group}) ;;
  }
}
