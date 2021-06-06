view: sales {
  sql_table_name: `leafy-habitat-174801.dataform_magento.sales`;;
  drill_fields: [order_detail*]

  dimension: applied_rule_ids {
    type: string
    sql: ${TABLE}.applied_rule_ids ;;
    label: "Rule Ids"
  }

  dimension: base_discount_amount {
    label: "Discount"
    type: number
    sql: ${TABLE}.base_discount_amount ;;
  }

  dimension: base_grand_total {
    label: "Total"
    type: number
    sql: ${TABLE}.base_grand_total ;;
  }

  dimension: cod {
    label: "COD"
    type: number
    sql: ${TABLE}.base_msp_cod_amount + ${TABLE}.base_msp_cod_tax_amount;;
  }

  dimension: base_shipping_incl_tax {
    label: "Shipping"
    type: number
    sql: ${TABLE}.base_shipping_incl_tax ;;
  }

  dimension: subtotal_incl_tax {
    label: "Subtotal"
    type: number
    sql: ${TABLE}.subtotal_incl_tax ;;
  }

  dimension: base_tax_amount {
    label: "Tax"
    type: number
    sql: ${TABLE}.base_tax_amount ;;
  }

  dimension: coupon_code {
    label: "Coupon"
    type: string
    sql: ${TABLE}.coupon_code ;;
  }

  dimension_group: created {
    label: "Order Date"
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
    type: string
    sql: ${TABLE}.customer_email ;;
  }

  dimension: customer_firstname {
    type: string
    sql: ${TABLE}.customer_firstname ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    link: {
      label: "See details"
      url: "/dashboards-next/29?Customer%20ID={{ value }}"
    }
  }

  dimension: customer_lastname {
    type: string
    sql: ${TABLE}.customer_lastname ;;
  }

  dimension_group: delivery {
    label: "Delivery Date"
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

  dimension: total_item_count {
    label: "Item Count"
    description: "Number of unique item of an order"
    type: number
    sql: ${TABLE}.total_item_count ;;
  }

  dimension: total_qty_ordered {
    label: "Quantity"
    type: number
    sql: ${TABLE}.total_qty_ordered ;;
  }

  dimension: order_type {
    label: "Order type"
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

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
    convert_tz: no
  }

  dimension: order_sequence {
    description: "Sequence of order per customer"
    type: number
    sql: ${TABLE}.order_sequence ;;
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

  measure: count {
    label: "Count of Order"
    type: count
  }

  measure: unique_user_count {
    label: "Count of Unique Customer"
    type: count_distinct
    sql: ${customer_id} ;;
  }

  measure: total_sales {
    label: "Total Sales"
    type: sum
    sql: ${base_grand_total} ;;
  }

  measure: avg_sales {
    label: "Average Sales"
    type: average
    sql: ${base_grand_total} ;;
    value_format: "0"
  }

  measure: total_items_sold {
    label: "Total Items Sold"
    type: sum
    sql: ${total_qty_ordered} ;;
  }

  set: order_detail {
    fields: [customer_id, customer_email, customer_firstname, customer_lastname, entity_id, increment_id, created_date, status]
  }
}
