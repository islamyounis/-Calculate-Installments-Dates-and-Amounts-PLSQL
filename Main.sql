
CREATE OR REPLACE PROCEDURE INST_DATA
IS
  
  V_amu number(10) := 0;
  V_num_mon number(10) := 0;
  V_pay_date date;
  

  CURSOR CON_CUR
  IS
  SELECT * FROM CONTRACTS;

BEGIN
  FOR V_rec_con IN CON_CUR
  LOOP
  
    if V_rec_con.CONTRACT_PAYMENT_TYPE = 'ANNUAL' then
      BEGIN
        V_pay_date := V_rec_con.CONTRACT_STARTDATE;
        while V_pay_date < V_rec_con.CONTRACT_ENDDATE
        LOOP
         
          V_num_mon := MONTHS_BETWEEN(V_rec_con.CONTRACT_ENDDATE, V_pay_date) ;
          V_amu := ((V_rec_con.CONTRACT_TOTAL_FEES - NVL(V_rec_con.CONTRACT_DEPOSIT_FEES, 0))) / (V_num_mon / 12);
          V_pay_date := ADD_MONTHS(V_pay_date, 12);
          
         insert into installments_paid (INSTALLMENT_ID,CONTRACT_ID,INSTALLMENT_AMOUNT,INSTALLMENT_DATE,PAID)
         values (INST_SEQ.nextval ,V_rec_con.CONTRACT_ID,V_amu, V_pay_date, 0);
          
        END LOOP;
      END;
    end if;
    
    
      if V_rec_con.CONTRACT_PAYMENT_TYPE = 'HALF_ANNUAL' then
      BEGIN
        V_pay_date := V_rec_con.CONTRACT_STARTDATE;
        while V_pay_date < V_rec_con.CONTRACT_ENDDATE
        LOOP
         
          V_num_mon := MONTHS_BETWEEN(V_rec_con.CONTRACT_ENDDATE, V_pay_date) ;
          V_amu := ((V_rec_con.CONTRACT_TOTAL_FEES - NVL(V_rec_con.CONTRACT_DEPOSIT_FEES, 0))) / (V_num_mon / 6);
          V_pay_date := ADD_MONTHS(V_pay_date, 6);
          
         insert into installments_paid (INSTALLMENT_ID,CONTRACT_ID,INSTALLMENT_AMOUNT,INSTALLMENT_DATE,PAID)
         values (INST_SEQ.nextval ,V_rec_con.CONTRACT_ID,V_amu, V_pay_date, 0);
         
        END LOOP;
      END;
    end if;
    
      if V_rec_con.CONTRACT_PAYMENT_TYPE = 'QUARTER' then
      BEGIN
        V_pay_date := V_rec_con.CONTRACT_STARTDATE;
        while V_pay_date < V_rec_con.CONTRACT_ENDDATE
        LOOP
         
          V_num_mon := MONTHS_BETWEEN(V_rec_con.CONTRACT_ENDDATE, V_pay_date) ;
          V_amu := ((V_rec_con.CONTRACT_TOTAL_FEES - NVL(V_rec_con.CONTRACT_DEPOSIT_FEES, 0))) / (V_num_mon / 3);
          V_pay_date := ADD_MONTHS(V_pay_date, 3);
          
         insert into installments_paid (INSTALLMENT_ID,CONTRACT_ID,INSTALLMENT_AMOUNT,INSTALLMENT_DATE,PAID)
         values (INST_SEQ.nextval ,V_rec_con.CONTRACT_ID,V_amu, V_pay_date, 0);
         
        END LOOP;
      END;
    end if;
    
      if V_rec_con.CONTRACT_PAYMENT_TYPE = 'MONTHLY' then
      BEGIN
        V_pay_date := V_rec_con.CONTRACT_STARTDATE;
        while V_pay_date < V_rec_con.CONTRACT_ENDDATE
        LOOP
         
          V_num_mon := MONTHS_BETWEEN(V_rec_con.CONTRACT_ENDDATE, V_pay_date) ;
          V_amu := ((V_rec_con.CONTRACT_TOTAL_FEES - NVL(V_rec_con.CONTRACT_DEPOSIT_FEES, 0))) / (V_num_mon );
          V_pay_date := ADD_MONTHS(V_pay_date, 1);
          
         insert into installments_paid (INSTALLMENT_ID,CONTRACT_ID,INSTALLMENT_AMOUNT,INSTALLMENT_DATE,PAID)
         values (INST_SEQ.nextval ,V_rec_con.CONTRACT_ID,V_amu, V_pay_date, 0);
         
        END LOOP;
      END;
    end if;
    
  END LOOP;
END;
