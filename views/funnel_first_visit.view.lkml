view: funnel_first_visit {
  sql_table_name: `leafy-habitat-174801.customer_journey.funnel_first_visit`
    ;;

  dimension: campaign_medium {
    type: string
    sql: ${TABLE}.campaign_medium ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_source {
    type: string
    sql: ${TABLE}.campaign_source ;;
  }

  dimension: campaign_term {
    type: string
    sql: ${TABLE}.campaign_term ;;
  }

  dimension: first_page {
    type: string
    sql: ${TABLE}.first_page ;;
  }

  dimension: first_website {
    type: string
    sql: ${TABLE}.first_website ;;
  }

  dimension: acquisition_source {
    type: string
    sql: CASE
          WHEN ${campaign_source} = 'google' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'search' AND ${campaign_term} = 'brand' THEN 'Google_Search_Brand'
          WHEN ${campaign_source} = 'google' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'search' AND ${campaign_term} = 'breed' THEN 'Google_Search_Breed'
          WHEN ${campaign_source} = 'google' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'search' AND ${campaign_term} = 'broad' THEN 'Google_Search_Broad'
          WHEN ${campaign_source} = 'google' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'display' AND ${campaign_term} = 'audience' THEN 'Google_Display_Audience'
          WHEN ${campaign_source} = 'yahoo' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'search' AND ${campaign_term} = 'brand' THEN 'Yahoo_Search_Brand'
          WHEN ${campaign_source} = 'yahoo' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'search' AND ${campaign_term} = 'breed' THEN 'Yahoo_Search_Breed'
          WHEN ${campaign_source} = 'yahoo' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'search' AND ${campaign_term} = 'broad' THEN 'Yahoo_Search_Broad'
          WHEN ${campaign_source} = 'yahoo' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'display' AND ${campaign_term} = 'audience' THEN 'Yahoo_Display_Audience'
          WHEN ${campaign_source} = 'line' AND ${campaign_medium} = 'cpc' THEN 'LINE'
          WHEN ${campaign_source} = 'facebook' AND ${campaign_medium} = 'cpc' AND ${campaign_name} LIKE '%ls_%' THEN 'Facebook_Leads'
          WHEN ${campaign_source} = 'facebook' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'leads' THEN 'Facebook_Leads'
          WHEN ${campaign_source} = 'facebook' AND ${campaign_medium} = 'cpc' AND ${campaign_name} LIKE '%cv_%' THEN 'Facebook_Conversion'
          WHEN ${campaign_source} = 'facebook' AND ${campaign_medium} = 'cpc' AND ${campaign_name} = 'conversion' THEN 'Facebook_Conversion'
          WHEN ${campaign_source} = 'google' AND ${campaign_medium} = 'organic' THEN 'Google_organic'
          WHEN ${campaign_source} = 'yahoo' AND ${campaign_medium} = 'organic' THEN 'Yahoo_organic'
          WHEN ${campaign_source} = 'direct' AND ${campaign_medium} = 'none' THEN 'Direct_none'
          WHEN ${campaign_source} = 'direct' AND ${campaign_medium} = 'none' THEN 'Direct_none'
          WHEN ${campaign_source} = 'klaviyo' AND ${campaign_medium} = 'email' THEN 'Klaviyo_email'
          WHEN ${campaign_source} = 'instagram' AND ${campaign_medium} = 'profile' THEN 'Instagram_profile'
        END ;;
  }

  dimension: dummy_three {
    case: {
      when: {
        label: "1st page"
        sql: 1=1 ;;
      }
      when: {
        label: "Karte page"
        sql: 1=1 ;;
      }
      when: {
        label: "Lead"
        sql: 1=1 ;;
      }
      when: {
        label: "Karte Completed"
        sql: 1=1 ;;
      }
      when: {
        label: "Cart"
        sql: 1=1 ;;
      }
      when: {
        label: "Order"
        sql: 1=1 ;;
      }
    }
  }

  dimension_group: cart_viewed {
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
    sql: ${TABLE}.first_cart_viewed_date_ts ;;
  }

  dimension_group: create_karte_viewed {
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
    sql: ${TABLE}.first_create_karte_viewed_date_ts ;;
  }

  dimension_group: karte_created {
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
    sql: ${TABLE}.first_karte_date_ts ;;
  }

  dimension_group: lead_completed {
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
    sql: ${TABLE}.first_lead_date_ts ;;
  }

  dimension_group: order_completed {
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
    sql: ${TABLE}.first_order_date_ts ;;
  }

  dimension_group: first_visit {
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
    sql: ${TABLE}.first_visit_ts ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
  }

  measure: count_cart_viewed {
    type: number
    sql: COUNT(${cart_viewed_date}) ;;
  }

  measure: count_create_karte_viewed {
    type: number
    sql: COUNT(${create_karte_viewed_date}) ;;
  }

  measure: count_karte_created {
    type: number
    sql: COUNT(${karte_created_date}) ;;
  }

  measure: count_lead_completed {
    type: number
    sql: COUNT(${lead_completed_date}) ;;
  }

  measure: count_order_completed {
    type: number
    sql: COUNT(${order_completed_date}) ;;
  }

  measure: count_first_visit {
    type: number
    sql: COUNT(${first_visit_date}) ;;
  }
}
