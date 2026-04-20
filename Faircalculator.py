rates={
    "Economy" : 10,
    "Premium" : 18,
    "SUV" : 25
}
def calculate_fare(distance, vehicle_type,hour):
    if vehicle_type not in rates:
        return "Service Not Available"
    fare = distance * rates[vehicle_type]
    if 17<=hour<=20:
        surge_multiplier = 1.5
    else:
        surge_multiplier = 1
    total_fare = fare * surge_multiplier
    return total_fare

try:
    distance = float(input("Enter the distance to be traveled (in km): "))
    vehicle_type = input("Enter the type of vehicle (Economy, Premium, SUV): ")
    hour = int(input("Enter the hour of the day (0-23): "))
    fare = calculate_fare(distance, vehicle_type, hour)
    
    if fare == "Service Not Available":
        print("\n Service Not Available for the selected vehicle type.")
    else:
        print("\n -----CityCab Price Receipt-----")
        print(f"Distance Travelled: {distance} km")
        print(f"Vehicle Type: {vehicle_type}")
        print(f"Rate per km : ${rates[vehicle_type]}")
        print(f"Hours of Travel: {hour}")
        if 17<= hour <= 20:
            print("Surge Pricing : Applied (1.5x)")
        else:
            print("Surge Pricing : Not Applied")
        print(f"Total Fare: ${fare:.2f}")
        print("-------------------------------")
except ValueError:
    print("Invalid input. Please enter correct numeric values.")