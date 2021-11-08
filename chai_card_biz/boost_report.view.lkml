view: boost_report {
  derived_table: {
    sql: select
      *, b.cashback_amount-b."new_ad_spend" as "new_chai_credit"
      from (
      select
      a.*, cast(a.merchant_ratio as numeric(10,4)),
      case when a.name in ('현대백화점투홈') then '5000'
      when a.name in ('설로인') then '5000'
      else cast(a.merchant_ratio as numeric(10,4)) * a.cashback_amount
      end as "New_ad_spend"
      from
      (select
      date(p.created_at),
      b2.name,
      bpp.type,
      bpp.promotion_type,
      bpp.title,
      p.id,
      b.payment_id,
      b.user_id,
      p.checkout_amount,
      p.cashback_amount,
      case when b2.name ='현대백화점투홈' then '5000'
        when b2.name ='설로인' then '5000'
        when b2.name ='뮬라웨어' then '1'
        when b2.name ='인더웨어' then '1'
        when b2.name ='인테이크' then '1'
        when b2.name ='아몬즈' then '1'
        when b2.name ='크로켓' then '1'
        when b2.name ='바잇미' then '0.7'
        when b2.name ='얌테이블' then '0.7'
        when b2.name ='디코드' then '0.7'
        when b2.name ='술담화' then '0.7'
        when b2.name ='다노샵' then '0.7'
        when b2.name ='위메프오' then '0.6'
        when b2.name ='아워홈' then '0.6'
        when b2.name ='그린카' then '0.5'
        when b2.name ='젝시믹스' then '0.5'
        when b2.name ='펫프렌즈' then '0.5'
        when b2.name ='어바웃펫' then '0.5'
        when b2.name ='쿠쿠몰' then '0.5'
        when b2.name ='아모레몰' then '0.5'
        when b2.name ='에이블리' then '0.5'
        when b2.name ='해피머니' then '0.5'
        when b2.name ='프립' then '0.5'
        when b2.name ='카모아' then '0.5'
        when b2.name ='무신사' then '0.3'
        when b2.name ='에릭 요한슨 사진전' then '0.5'
        when b2.name ='티몬 스키시즌 오픈!' then '0.5'
        when b2.name ='KKday' then '0.7'
        when b2.name ='롭스' then '0.5'
      end as "merchant_ratio",
      bh.ad_spend,
      bh.chai_credit
      from raw_rds_production.brand b2
      left join raw_rds_production.boost_promotion_policy bpp on b2.id = bpp.brand_id
      left join raw_rds_production.boost b on bpp.id = b.boost_promotion_id
      left join raw_rds_production.payment p on p.id = b.payment_id
      left join raw_rds_production.boost_budget_usage_history bh on bh.payment_id = p.id
      where p.status = 'confirmed'
      )a
      )b
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: boost_count{
    type: count_distinct
    sql: ${TABLE}.payment_id ;;
  }

  measure: total_new_ad_spend {
    type: sum
    sql: ${TABLE}."new_ad_spend" ;;
  }

  measure: total_new_chai_credit {
    type: sum
    sql: ${TABLE}."new_chai_credit" ;;
  }

  measure: customer_count{
    type: count_distinct
    sql: ${TABLE}.user_id ;;
  }

  measure: boost_tx {
    type: sum
    sql: ${TABLE}.checkout_amount ;;
  }

  measure: total_cashback_amount {
    type: sum
    sql: ${cashback_amount} ;;
  }

  measure: total_ad_spend{
    type: sum
    sql: ${TABLE}.ad_spend ;;
  }

  measure: total_chai_credit{
    type: sum
    sql: ${TABLE}.chai_credit ;;
  }

  dimension: date {
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension_group: date_field {
    type: time
    timeframes: [year, month, week, month_num, month_name, date, week_of_year]
    sql: ${TABLE}.date ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: payment_id {
    type: string
    sql: ${TABLE}.payment_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }


  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: promotion_type{
    type: string
    sql: ${TABLE}.promotion_type ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: cashback_amount {
    type: number
    sql: ${TABLE}.cashback_amount ;;
  }

  dimension: checkout_amount {
    type: number
    sql: ${TABLE}.checkout_amount ;;
  }

  dimension: ad_spend {
    type: number
    sql: ${TABLE}.ad_spend ;;
  }

  dimension: chai_credit {
    type: number
    sql: ${TABLE}.chai_credit ;;
  }

  set: detail {
    fields: [
      date,
      name,
      type,
      title,
      promotion_type,
      id,
      payment_id,
      user_id,
      checkout_amount,
      cashback_amount,
      ad_spend,
      chai_credit
    ]
  }
}
