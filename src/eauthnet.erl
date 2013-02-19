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

-module(eauthnet).

-export([new_params/0,
         new_params/2,
         new_params/3,
         charge/1,
         charge/4]).

-define(DEFAULT_URL, <<"https://secure.authorize.net/gateway/transact.dll">>).
-define(DEFAULT_TEST_URL, <<"https://test.authorize.net/gateway/transact.dll">>).
-define(DEFAULT_LOGIN, <<"CHANGE_ME">>).
-define(DEFAULT_TRAN_KEY, <<"CHANGE_ME">>).

-define(WITH_DEFAULT(X, Y), case X of
                                undefined ->
                                    {ok, Y};
                                _ ->
                                    X
                            end).

-record(authnet_params, {url, login, tran_key, type, card_num, exp_date, amount, card_code}).
-record(authnet_result, {response_code, response_subcode, response_reason_code, response_reason_text, approval_code, avs_result_code, transaction_id, invoice_number, description, amount, method, transaction_type, customer_id, cardholder_first_name, cardholder_last_name, company, billing_address, city, state, zip, country, phone, fax, email, ship_to_first_name, ship_to_last_name, ship_to_company, ship_to_address, ship_to_city, ship_to_state, ship_to_zip, ship_to_country, tax_amount, duty_amount, freight_amount, tax_exempt_flag, po_number, md5_hash, card_code_response_code, cavv_response_code}).

%%%===================================================================
%%% New record functions
%%%===================================================================

-spec new_params() -> record(authnet_params).
new_params() ->
    {ok, URL} = ?WITH_DEFAULT(application:get_env(eauthnet, url), ?DEFAULT_URL),
    {ok, Login} = ?WITH_DEFAULT(application:get_env(eauthnet, login), ?DEFAULT_LOGIN),
    {ok, TranKey} = ?WITH_DEFAULT(application:get_env(eauthnet, tran_key), ?DEFAULT_TRAN_KEY),
    #authnet_params{url=URL, login=Login, tran_key=TranKey}.

-spec new_params(binary(), binary()) -> record(authnet_params).
new_params(Login, TranKey) ->
    {ok, URL} = ?WITH_DEFAULT(application:get_env(eauthnet, url), ?DEFAULT_URL),
    #authnet_params{url=URL, login=Login, tran_key=TranKey}.

-spec new_params(binary(), binary(), binary()) -> record(authnet_params).
new_params(URL, Login, TranKey) ->
    #authnet_params{url=URL, login=Login, tran_key=TranKey}.

-spec new_result([binary()]) -> record(authnet_result).
new_result([ResponseCode, ResponseSubcode, ResponseReasonCode, ResponseReasonText, ApprovalCode, AVSResultCode, TransactionID, InvoiceNumber, Description, Amount, Method, TransactionType, CustomerID, CardholderFirstName, CardholderLastName, Company, BillingAddress, City, State, Zip, Country, Phone, Fax, Email, ShipToFirstName, ShipToLastName, ShipToCompany, ShipToAddress, ShipToCity, ShipToState, ShipToZip, ShipToCountry, TaxAmount, DutyAmount, FreightAmount, TaxExemptFlag, PONumber, MD5Hash, CardCodeResponseCode, CAVVResponseCode | _T]) ->
    #authnet_result{response_code=ResponseCode, response_subcode=ResponseSubcode, response_reason_code=ResponseReasonCode, response_reason_text=ResponseReasonText, approval_code=ApprovalCode, avs_result_code=AVSResultCode, transaction_id=TransactionID, invoice_number=InvoiceNumber, description=Description, amount=Amount, method=Method, transaction_type=TransactionType, customer_id=CustomerID, cardholder_first_name=CardholderFirstName, cardholder_last_name=CardholderLastName, company=Company, billing_address=BillingAddress, city=City, state=State, zip=Zip, country=Country, phone=Phone, fax=Fax, email=Email, ship_to_first_name=ShipToFirstName, ship_to_last_name=ShipToLastName, ship_to_company=ShipToCompany, ship_to_address=ShipToAddress, ship_to_city=ShipToCity, ship_to_state=ShipToState, ship_to_zip=ShipToZip, ship_to_country=ShipToCountry, tax_amount=TaxAmount, duty_amount=DutyAmount, freight_amount=FreightAmount, tax_exempt_flag=TaxExemptFlag, po_number=PONumber, md5_hash=MD5Hash, card_code_response_code=CardCodeResponseCode, cavv_response_code=CAVVResponseCode}.


%%%===================================================================
%%% Charge functions
%%%===================================================================

-spec charge(record(authnet_params)) -> record(authnet_result).
charge(AuthParams) ->
    Method = post,
    URL = AuthParams#authnet_params.url,
    Login = AuthParams#authnet_params.login,
    TranKey = AuthParams#authnet_params.tran_key,
    CardNum = AuthParams#authnet_params.card_num,
    ExpDate = AuthParams#authnet_params.exp_date,
    CardCode = AuthParams#authnet_params.card_code,
    Amount = AuthParams#authnet_params.amount,
    Headers = [],
    Payload = << <<"x_delim_data=TRUE&x_delim_char=|&x_relay_response=FALSE&x_url=FALSE&x_version=3.1&x_method=CC&x_type=AUTH_CAPTURE&x_login=">>/binary, Login/binary, <<"&x_tran_key=">>/binary , TranKey/binary, <<"&x_card_num=">>/binary, CardNum/binary, <<"&x_exp_date=">>/binary, ExpDate/binary, <<"&x_amount=">>/binary, Amount/binary, <<"&x_po_num=0&x_tax=0&x_card_code=">>/binary, CardCode/binary >>,
    Options = [],
    {ok, _StatusCode, _RespHeaders, Client} = hackney:request(Method, URL, Headers, Payload, Options),
    {ok, Body, _Client1} = hackney:body(Client),
    new_result(binary:split(Body, [<<"|">>], [global])).

-spec charge(binary(), binary(), binary(), binary()) -> record(authnet_result).
charge(CardNum, ExpDate, CardCode, Amount) ->
    AuthParams = new_params(),
    AuthParams2 = AuthParams#authnet_params{card_num=CardNum, exp_date=ExpDate, card_code=CardCode, amount=Amount},
    charge(AuthParams2).
