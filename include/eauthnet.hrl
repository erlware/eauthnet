%% -*- erlang-indent-level: 4; indent-tabs-mode: nil; fill-column: 80 -*-
%%% Copyright 2012 Erlware, LLC. All Rights Reserved.
%%%
%%% This file is provided to you under the Apache License,
%%% Version 2.0 (the "License"); you may not use this file
%%% except in compliance with the License.  You may obtain
%%% a copy of the License at
%%%
%%%   http://www.apache.org/licenses/LICENSE-2.0
%%%
%%% Unless required by applicable law or agreed to in writing,
%%% software distributed under the License is distributed on an
%%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%%% KIND, either express or implied.  See the License for the
%%% specific language governing permissions and limitations
%%% under the License.
%%%---------------------------------------------------------------------------
%%% @author Jordan Wilberding <jwilberding@gmail.com>
%%% @copyright (C) 2013 Erlware, LLC.
%%%
%%% @doc 
%%%  Definition of records for authnet params and result
%%% @end

-record(authnet_params, {url, login, tran_key, type, card_num, exp_date, amount,
                         card_code}).
-record(authnet_result, {response_code, response_subcode, response_reason_code,
                         response_reason_text, approval_code, avs_result_code,
                         transaction_id, invoice_number, description, amount,
                         method, transaction_type, customer_id,
                         cardholder_first_name, cardholder_last_name, company,
                         billing_address, city, state, zip, country, phone, fax,
                         email, ship_to_first_name, ship_to_last_name,
                         ship_to_company, ship_to_address, ship_to_city,
                         ship_to_state, ship_to_zip, ship_to_country,
                         tax_amount, duty_amount, freight_amount,
                         tax_exempt_flag, po_number, md5_hash,
                         card_code_response_code, cavv_response_code}).
