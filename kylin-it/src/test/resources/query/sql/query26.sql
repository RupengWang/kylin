--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

SELECT 
 test_cal_dt.week_beg_dt 
 ,test_category_groupings.meta_categ_name 
 ,test_category_groupings.categ_lvl2_name 
 ,test_category_groupings.categ_lvl3_name 
 ,test_kylin_fact.lstg_format_name 
 ,test_sites.site_name 
 ,test_seller_type_dim.seller_type_desc 
 ,sum(test_kylin_fact.price) as GMV 
 , count(*) as TRANS_CNT 
 FROM test_kylin_fact 
 inner JOIN edw.test_cal_dt as test_cal_dt 
 ON test_kylin_fact.cal_dt = test_cal_dt.cal_dt 
 inner JOIN test_category_groupings 
 ON test_kylin_fact.leaf_categ_id = test_category_groupings.leaf_categ_id AND test_kylin_fact.lstg_site_id = test_category_groupings.site_id 
 inner JOIN edw.test_sites as test_sites 
 ON test_kylin_fact.lstg_site_id = test_sites.site_id 
 inner JOIN edw.test_seller_type_dim as test_seller_type_dim 
 ON test_kylin_fact.slr_segment_cd = test_seller_type_dim.seller_type_cd 
 where test_cal_dt.week_beg_dt between DATE '2013-01-01' and DATE '2013-06-04' 
 and (test_category_groupings.meta_categ_name='Collectibles' or test_category_groupings.meta_categ_name='Clothing, Shoes & Accessories') and 
 test_category_groupings.categ_lvl3_name <>'Other' and test_sites.site_name='Ebay' 
 group by test_cal_dt.week_beg_dt 
 ,test_category_groupings.meta_categ_name 
 ,test_category_groupings.categ_lvl2_name 
 ,test_category_groupings.categ_lvl3_name 
 ,test_kylin_fact.lstg_format_name 
 ,test_sites.site_name 
 ,test_seller_type_dim.seller_type_desc 
 
;{"scanRowCount":0,"scanBytes":0,"scanFiles":0,"cuboidId":2097151}