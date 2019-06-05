# birthday.py

import mydate

def duplicates(list_of_dates):

	seen = []
	dupe = []

	for x in list_of_dates:

		if x not in seen:

			seen.append(x)

		else:

			dupe.append(x)

	return dupe

def dupe_to_string(dupe):

	s1 = "(" + mydate.month_num_to_string(dupe[0][0]) + " " + str(dupe[0][1])

	if len(dupe) == 1:

		s1 += ")"
	else:

		for i in range(len(dupe) - 2):

			s1 += ", " + mydate.month_num_to_string(dupe[i + 1][0]) + " " + str(dupe[i + 1][1])

		s1 += ", " + mydate.month_num_to_string(dupe[len(dupe) - 1][0]) + " " + str(dupe[len(dupe) - 1][1]) + ")"

	return s1

print()

num_trials = int(input("How many times should I run the simulation? "))

num_bdays = int(input("How many birthdays should I generate per trial? "))

print()

trials_with_dupe = 0

for i in range(num_trials):

	b_days = []

	for j in range(num_bdays):

		date = mydate.generate_date(1960, 2017)

		b_days.append(date)

	b_day1 = mydate.remove_years(b_days)

	dupe = duplicates(b_day1)

	trial_summary = ""

	if len(dupe) == 0: 

		trial_summary = "Trial #" + str(i + 1) + ": No dates are the same."

	else:

		trials_with_dupe += 1

		trial_summary = "Trial #" + str(i + 1) + ": " + str(len(dupe)) + " date(s) occur more than once!"

		trial_summary += dupe_to_string(dupe)

	print(trial_summary)

print()
print("Results:\n=====\n")

probability = (trials_with_dupe/num_trials)*100

print("Out of", str(num_trials), ",", str(trials_with_dupe), "had dates that were repeated.")
print("We can conclude that you have a", format(probability, ".2f") + "%", "chance of sharing a birthday with someone if you are in a group of", num_bdays, "people.")
print()



