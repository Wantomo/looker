view: klaviyo_events_aggregated {
  derived_table: {
    sql:  WITH
              events_aggregated AS (
              SELECT
                DATE(timestamp) AS date,
                utm,
                flow,
                flow_id,
                type,
                COUNT(DISTINCT(CASE
                      WHEN event = 'Received Email' THEN email
                  END
                    )) AS receive,
                COUNT(DISTINCT(CASE
                      WHEN event = 'Opened Email' THEN email
                  END
                    )) AS open,
                COUNT(DISTINCT(CASE
                      WHEN event = 'Clicked Email' THEN email
                  END
                    )) AS click,
                COUNT(DISTINCT(CASE
                      WHEN event = 'Unsubscribed' THEN email
                  END
                    )) AS unsubscribe
              FROM
                `leafy-habitat-174801.dataform_klaviyo.events`
              GROUP BY
                1,
                2,
                3,
                4,
                5),
              add_transactions AS (
              SELECT
                events_aggregated.*,
              IF
                (orders.count IS NOT NULL,
                  orders.count,
                  0) AS order_count,
              IF
                (orders.revenue IS NOT NULL,
                  orders.revenue,
                  0) AS order_revenue
              FROM
                events_aggregated
              LEFT JOIN (
                SELECT
                  DATE(order_date) AS date,
                  campaign_name AS utm,
                  COUNT(entity_id) AS count,
                  SUM(order_revenue) AS revenue
                FROM
                  `leafy-habitat-174801.dataform_segment.last_touch_utm`
                GROUP BY
                  1,
                  2 ) AS orders
              ON
                orders.utm = events_aggregated.utm
                AND orders.date = events_aggregated.date)
            SELECT
              TIMESTAMP(date) as date,
              flow as name,
              flow_id,
              type,
              SUM(receive) AS receive,
              SUM(open) AS open,
              SUM(click) AS click,
              SUM(unsubscribe) AS unsubscribe,
              SUM(order_count) AS order_count,
              SUM(order_revenue) AS order_revenue
            FROM
              add_transactions
            WHERE type = "Drip"
            GROUP BY
              1,
              2,
              3,
              4
            UNION ALL
            SELECT
              TIMESTAMP(date) as date,
              utm as name,
              flow_id,
              type,
              receive,
              open,
              click,
              unsubscribe,
              order_count,
              order_revenue
            FROM
              add_transactions
            WHERE type != "Drip"
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

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: flow_id {
    type: number
    sql: ${TABLE}.flow_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: receive {
    type: sum
    sql: ${TABLE}.receive ;;
  }

  measure: open {
    type: sum
    sql: ${TABLE}.open ;;
  }

  measure: click {
    type: sum
    sql: ${TABLE}.click ;;
  }

  measure: unsubscribe {
    type: sum
    sql: ${TABLE}.unsubscribe ;;
  }

  measure: order_count {
    type: sum
    sql: ${TABLE}.order_count ;;
  }

  measure: order_revenue {
    type: sum
    sql: ${TABLE}.order_revenue ;;
  }

  measure: OPR {
    type: number
    sql: ${open} / NULLIF(${receive}, 0)  * 100;;
    value_format: "0.00\%"
  }

  measure: CTR {
    type: number
    sql: ${click} / NULLIF(${receive}, 0)  * 100;;
    value_format: "0.00\%"
  }

  measure: CVR {
    type: number
    sql: ${order_count} / NULLIF(${receive}, 0)  * 100;;
    value_format: "0.00\%"
  }

}
