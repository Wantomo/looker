view: sales_sequence {
    derived_table: {
      # Sequence orders and create Segments
      sql:  SELECT
              order_id,
              increment_id,
              customer_id,
              created_at,
              base_grand_total,
              is_subscription,
              order_sequence,
              CASE
                WHEN order_sequence = 1 THEN '1-First Order'
                WHEN order_sequence = 2 THEN '2-First Repeat Order'
                WHEN order_sequence BETWEEN 3 AND 4 THEN '3-Repeater'
                WHEN order_sequence > 4 THEN '4-Loyal'
              END AS customer_segment
            FROM (
              SELECT
                entity_id AS order_id,
                increment_id,
                customer_id,
                created_at,
                base_grand_total,
                is_subscription,
                ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY entity_id ASC) AS order_sequence
              FROM ${sales.SQL_TABLE_NAME}
            )
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
    convert_tz: no
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

  dimension: increment_id {
    description: "Real order ID for each order"
    type: string
    sql: ${TABLE}.increment_id ;;
  }

  dimension: is_subscription {
    type: number
    sql: ${TABLE}.is_subscription ;;
  }

  dimension: order_sequence {
    description: "Sequence of order per customer"
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  dimension: customer_segment {
    description: "Customer Segment : 1st (1 order), 1st Repeat (2 orders), Repeater (3 to 4 orders), Loyal (5 and more orders)"
    type: string
    sql: ${TABLE}.customer_segment ;;
  }

  dimension: order_segment {
    type: string
    description: "Order Segment : 1st vs Repeat, Regular vs Subscription"
    sql:  CASE
              WHEN ${order_sequence} = 1 AND ${is_subscription} = 0 THEN '1-First Order Regular'
              WHEN ${order_sequence} = 1 AND ${is_subscription} = 1 THEN '2-First Order Subscription'
              WHEN ${order_sequence} > 1 AND ${is_subscription} = 0 THEN '3-Repeat Order Regular'
              WHEN ${order_sequence} > 1 AND ${is_subscription} = 1 THEN '4-Repeat Order Subscription'
          END ;;
  }

  dimension: is_first_order {
    type: yesno
    sql:  ${order_sequence} = 1 ;;
  }

  dimension: is_first_repeat_order {
    type: yesno
    sql:  ${order_sequence} = 2 ;;
  }

  dimension: is_repeat_order {
    type: yesno
    sql:  ${order_sequence} > 1 ;;
  }

  dimension: base_grand_total {
    type: number
    sql: ${TABLE}.base_grand_total ;;
  }
}
