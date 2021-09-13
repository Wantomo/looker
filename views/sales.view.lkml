view: sales {
  sql_table_name: `leafy-habitat-174801.dataform_magento.sales`;;
  drill_fields: [order_detail*]

  dimension: applied_rule_ids {
    type: string
    sql: ${TABLE}.applied_rule_ids ;;
  }

  dimension: base_discount_amount {
    label: "Discount"
    group_label: "Totals"
    type: number
    sql: ${TABLE}.base_discount_amount ;;
  }

  dimension: base_grand_total {
    label: "Total"
    group_label: "Totals"
    type: number
    sql: ${TABLE}.base_grand_total ;;
  }

  dimension: gross_revenue {
    label: "Gross Revenue"
    group_label: "Totals"
    type: number
    sql: ${base_grand_total} + ${base_discount_amount}*-1 ;;
  }

  dimension: cod {
    label: "COD"
    group_label: "Totals"
    type: number
    sql: ${TABLE}.base_msp_cod_amount + ${TABLE}.base_msp_cod_tax_amount;;
  }

  dimension: base_shipping_incl_tax {
    label: "Shipping"
    group_label: "Totals"
    type: number
    sql: ${TABLE}.base_shipping_incl_tax ;;
  }

  dimension: subtotal_incl_tax {
    label: "Subtotal"
    group_label: "Totals"
    type: number
    sql: ${TABLE}.subtotal_incl_tax ;;
  }

  dimension: base_tax_amount {
    label: "Tax"
    group_label: "Totals"
    type: number
    sql: ${TABLE}.base_tax_amount ;;
  }

  dimension: coupon_code {
    label: "Coupon"
    type: string
    sql: ${TABLE}.coupon_code ;;
  }

  dimension_group: created {
    label: "Order"
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }

  dimension: customer_email {
    label: "Email"
    group_label: "Customer"
    type: string
    sql: ${TABLE}.customer_email ;;
  }

  dimension: customer_firstname {
    label: "First name"
    group_label: "Customer"
    type: string
    sql: ${TABLE}.customer_firstname ;;
  }

  dimension: customer_id {
    label: "Id"
    group_label: "Customer"
    type: number
    sql: ${TABLE}.customer_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/29?Customer%20ID={{ value }}"
    }
  }

  dimension: customer_lastname {
    label: "Last name"
    group_label: "Customer"
    type: string
    sql: ${TABLE}.customer_lastname ;;
  }

  dimension_group: delivery {
    label: "Delivery"
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
    sql: ${TABLE}.delivery_date ;;
    convert_tz: no
  }

  dimension: delivery_time_range {
    label: "Delivery Time"
    type: number
    sql: ${TABLE}.delivery_time ;;
  }

  dimension: entity_id {
    label: "Internal Order Id"
    primary_key: yes
    type: number
    sql: ${TABLE}.entity_id ;;
  }

  dimension: increment_id {
    label: "Order ID"
    type: string
    sql: ${TABLE}.increment_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/31?Order%20ID={{ value }}"
    }
  }

  dimension: order_type {
    label: "Order Type"
    description: "Food (= 1)/frontline (= 2)"
    type: string
    sql:  CASE
            WHEN ${TABLE}.order_type = 2 THEN 'Frontline'
            ELSE 'Food'
          END ;;
  }

  dimension: is_subscription {
    label: "Is Subscription Order"
    type: yesno
    sql: ${TABLE}.is_subscription = 1 ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: order_sequence {
    description: "Sequence of order per customer"
    type: number
    sql: ${TABLE}.order_sequence ;;
  }

  dimension: order_sequence_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${order_sequence} ;;
  }

  dimension: order_sequence_food {
    description: "Sequence of food order per customer"
    type: number
    sql: ${TABLE}.order_sequence_food ;;
  }

  dimension: order_sequence_food_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${order_sequence_food} ;;
  }

  dimension: order_sequence_frontline {
    description: "Sequence of frontline order per customer"
    type: number
    sql: ${TABLE}.order_sequence_frontline ;;
  }

  dimension: order_sequence_frontline_tier {
    type: tier
    tiers: [1,2,3,5,10,20]
    style: integer
    sql: ${order_sequence_frontline} ;;
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

  dimension: customer_segment {
    description: "Customer Segment : 1st (1 order), 1st Repeat (2 orders), Repeater (3 to 4 orders), Loyal (5 and more orders)"
    type: string
    sql: CASE
            WHEN ${order_sequence} = 1 THEN '1-First Order'
            WHEN ${order_sequence} = 2 THEN '2-First Repeat Order'
            WHEN ${order_sequence} BETWEEN 3 AND 4 THEN '3-Repeater'
            WHEN ${order_sequence} > 4 THEN '4-Loyal'
        END ;;
  }

  measure: count {
    label: "Count of Order"
    type: count
  }

  measure: unique_user_count {
    label: "Count of Unique Order"
    type: count_distinct
    sql: ${customer_id} ;;
  }

  measure: total_sales {
    label: "Total Sales"
    type: sum_distinct
    sql_distinct_key: ${entity_id} ;;
    sql: ${base_grand_total} ;;
  }

  measure: total_gross_sales {
    label: "Total Gross Sales"
    type: sum_distinct
    sql_distinct_key: ${entity_id} ;;
    sql: ${gross_revenue} ;;
  }

  measure: total_discount {
    label: "Total Discount"
    type: sum_distinct
    sql_distinct_key: ${entity_id} ;;
    sql: ${base_discount_amount}*-1 ;;
  }

  measure: avg_sales {
    label: "Average Sales"
    type: average_distinct
    sql_distinct_key: ${entity_id} ;;
    sql: ${base_grand_total} ;;
    value_format: "0"
  }

  set: order_detail {
    fields: [customer_id, customer_email, customer_firstname, customer_lastname, entity_id, increment_id, created_date, status]
  }
}
