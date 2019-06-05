# mydate.py

import random

def is_valid_month_num(n):

    return (n >= 1 and n <= 12)

def month_num_to_string(month_num):
    
    months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
    
    if(is_valid_month_num(month_num)):
        return months[month_num - 1]
    else:
        return None


def date_to_string(date_list):
    
    month = month_num_to_string(date_list[1])
    
    date = month + ' ' + str(date_list[2]) + ', ' + str(date_list[0])
    
    return date

def dates_to_strings(list_of_date_lists):
    dates = []
    
    for i in list_of_date_lists:

        dates.append(date_to_string(i))

    return dates 

def remove_years(list_of_date_lists):

    new_list = []

    for i in list_of_date_lists:

        new_list.append(i[1:])

    return new_list

def is_leap_year(year):

    if year % 4 == 0:

        if year % 100 == 0:

            if year % 400 == 0:

                return True

            else:

                return False

        else:

            return True

    else:

        return False

def get_num_days_in_month(month_num, year):

    month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    if(is_valid_month_num(month_num)):

        if is_leap_year(year) and month_num == 2:

            return 29

        else:

            return month_days[month_num - 1]

    else:

        return None

def generate_date(start_year, end_year):

    year = random.randint(start_year, end_year)

    month = random.randint(1, 12)

    day = random.randint(1, get_num_days_in_month(month, year))

    return [year, month, day]




