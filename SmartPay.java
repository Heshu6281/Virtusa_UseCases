import java.util.*;
interface Billable{
        double calculateTotal(int units);    
    }
    class UtilityBill implements Billable {
        public double calculateTotal(int units) {
            double total = 0;
            if (units <= 100) {
                total = units * 1.0;
            } else if (units <= 300) {
                total = 100 * 1.0 + (units - 100) * 2.0;
            } else {
                total = 100 * 1.0 + 200 * 2.0 + (units - 300) * 5.0;
            }
            return total;
        }
    }
public class  SmartPay{
    public static void main(String[] args) {
        Scanner sc = new Scanner (System.in);
        UtilityBill ub = new UtilityBill();
        while (true) { 
            System.out.println("Enter Customer name or 'exit' to quit:");
            String customerName = sc.nextLine();
            if (customerName.equalsIgnoreCase("exit")) {
                break;
            }
            System.out.println("Enter previous meter reading:");
            int previousReading = sc.nextInt();
            System.out.println("Enter current meter reading:");
            int currentReading = sc.nextInt();
            sc.nextLine(); // Consume the newline

            if(previousReading > currentReading) {
                System.out.println("Error: Current reading must be greater than previous reading!");
                continue;
            }

            int unitsConsumed = currentReading - previousReading;
            double billAmount = ub.calculateTotal(unitsConsumed);

            double taxRate;
            if(unitsConsumed <= 100) {
                taxRate = 0.05; // 5% tax for up to 100 units
            } else if(unitsConsumed <= 300) {
                taxRate = 0.10; // 10% tax for 101-300 units
            } else {
                taxRate = 0.15; // 15% tax for above 300 units
            }
            double tax = billAmount * taxRate;

            double FinalAmount = billAmount + tax;
            System.out.println("=====DIGITAL RECEIPT=====");
            System.out.println("Customer Name  : " + customerName);
            System.out.println("Units Consumed : " + unitsConsumed);
            System.out.println("Bill Amount    : $" +billAmount);
            System.out.println("Tax Amount     : $" + tax);
            System.out.println("Final Amount   : $" + FinalAmount);
            System.out.println("===========================");
        }
    }
}