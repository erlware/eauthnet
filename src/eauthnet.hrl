%%%-------------------------------------------------------------------
%%% @author Jordan Wilberding <jwilberding@gmail.com>
%%% @copyright (C) 2013, Jordan Wilberding
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------

%% euthnet -- Erlang Authorize.net API -- Jordan Wilberding -- (C) 2013
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
