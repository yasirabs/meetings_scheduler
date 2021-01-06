# Meeting Scheduler

**Ruby Version :** ruby-2.6.3 

**Code Test :**
```
ruby meeting_scheduler.rb 
```

**Spec Test :**
```
rspec meeting_scheduler_spec.rb 
```

## Soluction Description

- The class initializes with two arguments #1 the list of meetings with schedule details and #2 total working hours of the day.
- If any of the initializers is nil it will exit from the execution of the function.
- Sort the list of meetings by onsite and offsite.
- Sum the list of the meeting hours by their duration.
- Filtering the total no of offsite meetings from the list and based on its count add 30 minutes to the duration of the sum of the count.
- Check if the sum of duration is greater than the total number of hours. It will return the "No, Cant fit" message.
- Execute loop over the meeting list and add the duration of time for each meeting. If the type is offsite add 30 minutes in the duration time. 
