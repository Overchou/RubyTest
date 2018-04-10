class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

class Calculs
   def initialize(rent)
     @contract_monthly_rent = rent

     @insurance_vat_rate = 0 # percentage | Fixed value	It is the vat rate applied to the Garantme insurance fees (Guarantor service)
     @vat_rate = 20.00 / 100 # percentage | Fixed value	It is the vat rate applied to the Garantme services (Customer support + access to the network of partners)
     @insurance_rate = 1.30 / 100 # percentage |	Fixed value	it is the insurance comission that Garantme needs to pay to his insurers
     @garantme_variable_rate = 3.50 / 100 # percentage |	Fixed value	it is the rate Garantme applies when the rent is higher than 870 €
     @garantme_fixed_rate = 365.00 # Fixed value	it is the rate that Garantme applies when the rent is lower than 870 €
     @lease_duration = 12.00	# Fixed value	it is the  duration of the apartment contract
     @broker_fee = 70.00	# Fixed value	The broker fee included in the Guarantor Pack
     @user_discount = 50.00 # Fixed value	A discount given to the user

     # -------------- HT ----------------- #

     @contract_annual_rent = determine_annual_rent(@lease_duration, @contract_monthly_rent)
     @garantme_applied_rate = determine_applied_rate

     @insurance_prenium = determine_insurance_prenium


     @guarantor_pack_base_price = determine_garantor_pack_base_price
     @total_insurance_fees = determine_total_insurance_fees

     @garantme_services_TTC = determine_garantme_services_ttc
     @VAT = determine_VAT

     @garantme_services_HT = determine_service_ht

     @price_excl_vat_sub_total = @insurance_prenium + @broker_fee + @garantme_services_HT
     @price_excl_vat_discount = @user_discount / (1 + @vat_rate)
     @price_excl_vat_total = @price_excl_vat_sub_total - @price_excl_vat_discount

     # -------------- VAT ----------------- #
     @insurance_prenium_VAT = determine_insurance_prenium_VAT
     @broker_fee_VAT = determine_broker_fee_VAT
     @service_fee_VAT = determine_service_fee_VAT
     @sub_total_VAT = @insurance_prenium_VAT + @broker_fee_VAT + @service_fee_VAT

     @discount_VAT = determine_discount_VAT
     @total_VAT = @sub_total_VAT - @discount_VAT

     # -------------- TTC ----------------- #
     @price_incl_vat_insurance = @insurance_prenium + @insurance_prenium_VAT
     @price_incl_vat_broker_fee = @broker_fee + @broker_fee_VAT
     @price_incl_vat_service_fee = @garantme_services_HT + @service_fee_VAT

     @price_incl_vat_sub_total = @price_incl_vat_insurance + @price_incl_vat_broker_fee + @price_incl_vat_service_fee
     @price_incl_vat_total = @price_incl_vat_sub_total - @user_discount
   end

   def determine_insurance_prenium
      @contract_annual_rent * @insurance_rate
   end

   def determine_annual_rent(a, b)
     a * b
   end

   def determine_applied_rate
     if @garantme_variable_rate * @contract_annual_rent > @garantme_fixed_rate
       @garantme_fixed_rate
     else
       @garantme_variable_rate
     end
   end

   def determine_garantor_pack_base_price
     if @garantme_variable_rate == @garantme_applied_rate
       if @garantme_fixed_rate * @contract_annual_rent > 365
         @garantme_fixed_rate
       else
         @garantme_fixed_rate * @contract_annual_rent
       end
     else
       @garantme_variable_rate * @contract_annual_rent
     end
   end

   def determine_total_insurance_fees
     @insurance_prenium + @broker_fee
   end

   def determine_service_ht
     # calcul du service TTC soustrait au VAT
     @garantme_services_TTC - @VAT
   end

   def determine_garantme_services_ttc
     @guarantor_pack_base_price - (@total_insurance_fees * (1 + @insurance_vat_rate))
   end

   def determine_VAT
     @vat_rate * @garantme_services_TTC / (1 + @vat_rate)
   end

   # --------------------------- #
   def determine_insurance_prenium_VAT
     @insurance_vat_rate * @garantme_variable_rate
   end

   def determine_broker_fee_VAT
     @insurance_vat_rate * @garantme_fixed_rate
   end

   def determine_service_fee_VAT
     @vat_rate * @garantme_services_HT
   end

   def determine_discount_VAT
     @vat_rate * @price_excl_vat_discount
   end
end
