QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = false -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
      unemployed = { label = 'Civilian', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Freelancer', payment = 0 } } },
      taxijob = { label = 'City Taxi', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 0 } } },
      builderjob = { label = 'City Constructions', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Worker', payment = 0 } } },
      electricianjob = { label = 'City Electricians', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Worker', payment = 0 } } },
      garbagejob = { label = 'Garbage Collector', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Worker', payment = 0 } } },
      gruppesechcsjob = { label = 'City Services', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Worker', payment = 0 } } },
      truckerjob = { label = 'City Deliveries', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 0 } } },
      judge = { label = 'City Courthouse', type = 'judge', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Judge', payment = 5000 } } },
      lawyer = { label = 'City Courthouse', type = 'lawyer', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Lawyer', payment = 500 } } },

      police = {
            label = 'Law Enforcement',
            type = 'leo',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Cadets', payment = 3510 },
                  ['1'] = { name = 'Officers', payment = 4025 },
                  ['2'] = { name = 'Senior Officers', payment = 4195 },
                  ['3'] = { name = 'Corporals', payment = 4370 },
                  ['4'] = { name = 'Detectives', payment = 4545 },
                  ['5'] = { name = 'Sergeants', payment = 4660 },
                  ['6'] = { name = 'Lieutenant', payment = 4770 },
                  ['7'] = { name = 'Captain', payment = 4890 },
                  ['8'] = { name = 'Assistant Chief', isboss = true, payment = 5120 },
                  ['9'] = { name = 'Chief of Police', isboss = true, payment = 5175 },
            },
      },
      ambulance = {
            label = 'City Central Hospital',
            type = 'ambulance',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0']  = { name = 'Apprentice',            payment = 1452 }, 
                  ['1']  = { name = 'Paramedic',             payment = 1983 }, 
                  ['2']  = { name = 'Senior Paramedic',      payment = 3108 }, 
                  ['3']  = { name = 'Paramedic Supervisor',  payment = 3342 }, 
                  ['4']  = { name = 'Paramedic Commander',   payment = 3571 }, 
                  ['5']  = { name = 'Narcologist',           payment = 4123 }, 
                  ['6']  = { name = 'Psychiatrist',          payment = 4123 }, 
                  ['7']  = { name = 'Junior Doctor',         payment = 4606 }, 
                  ['8']  = { name = 'Doctor',                payment = 4868 }, 
                  ['9']  = { name = 'Senior Doctor',         payment = 5003 }, 
                  ['10'] = { name = 'Hospital Consultant',   payment = 5257 }, 
                  ['11'] = { name = 'Deputy', isboss = true, payment = 5376 }, 
                  ['12'] = { name = 'Chief',  isboss = true, payment = 5534 }, 
            },
      },
      clerk = {
            label = 'Clerk',
            type = 'clerk',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Trainee', payment = 850 },                 -- Daily: 20,400
                  ['1'] = { name = 'Clerk', payment = 1050 },                  -- Daily: 25,200
                  ['2'] = { name = 'Senior Clerk', payment = 1300 },           -- Daily: 31,200
                  ['3'] = { name = 'Department Head', payment = 1500 },        -- Daily: 36,000
                  ['4'] = { name = 'Director', payment = 1800 },               -- Daily: 43,200
                  ['5'] = { name = 'Chief Executive Officer', payment = 1900 } -- Daily: 60,000

            },
      },
      weazel = {
            label = 'City Weazel News',
            type = 'weazel',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Intern', payment = 850 },                       -- Daily: 20,400
                  ['1'] = { name = 'Junior Reporter', payment = 1050 },             -- Daily: 25,200
                  ['2'] = { name = 'Reporter', payment = 1300 },                    -- Daily: 31,200
                  ['3'] = { name = 'Senior Reporter', payment = 1600 },             -- Daily: 38,400
                  ['4'] = { name = 'Editor-in-Chief', payment = 1800 },             -- Daily: 43,200
                  ['5'] = { name = 'News Director', isboss = true, payment = 1900 } -- Daily: 45,600

            },
      },
      cardealer = {
            label = 'Vice Car Dealer',
            type = 'cardealer',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Sales Associate', payment = 1000 },                -- Daily: 20,400
                  ['1'] = { name = 'Sales Consultant', payment = 1200 },               -- Daily: 26,400
                  ['2'] = { name = 'Sales Manager', payment = 1300 },                  -- Daily: 38,400
                  ['3'] = { name = 'General Manager', isboss = true, payment = 1400 }, -- Daily: 48,000
                  ['4'] = { name = 'Dealer Principal', isboss = true, payment = 1500 } -- Daily: 57,600

            },
      },
      planedealer = {
            label = 'Vice Plane Dealer',
            type = 'planedealer',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Sales Associate', payment = 1120 },                 -- Daily: 26,880
                  ['1'] = { name = 'Sales Consultant', payment = 1340 },                -- Daily: 32,160
                  ['2'] = { name = 'Sales Manager', payment = 2130 },                   -- Daily: 51,120
                  ['3'] = { name = 'General Manager', payment = 2350 },                 -- Daily: 56,400
                  ['4'] = { name = 'Dealer Principal', isboss = true, payment = 2580 }, -- Daily: 61,920
            },
      },
      repojob = {
            label = 'City Repair Service',
            type = 'repojob',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Junior Agent', payment = 600 },
                  ['1'] = { name = 'Repossession Agent', payment = 800 },
                  ['2'] = { name = 'Senior Agent', payment = 1200 },
                  ['3'] = { name = 'Field Supervisor', payment = 1600 },
                  ['4'] = { name = 'Operations Manager', isboss = true, payment = 2000 }
            },
      },
      repojob2 = {
            label = 'City Repair Service',
            type = 'repojob2',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Junior Agent', payment = 600 },
                  ['1'] = { name = 'Repossession Agent', payment = 800 },
                  ['2'] = { name = 'Senior Agent', payment = 1200 },
                  ['3'] = { name = 'Field Supervisor', payment = 1600 },
                  ['4'] = { name = 'Operations Manager', isboss = true, payment = 2000 }
            },
      },
      repojob3 = {
            label = 'City Repair Service',
            type = 'repojob3',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Junior Agent', payment = 600 },
                  ['1'] = { name = 'Repossession Agent', payment = 800 },
                  ['2'] = { name = 'Senior Agent', payment = 1200 },
                  ['3'] = { name = 'Field Supervisor', payment = 1600 },
                  ['4'] = { name = 'Operations Manager', isboss = true, payment = 2000 }
            },
      },
      mcdealer = {
            label = 'City Motorcycle Club',
            type = 'mcdealer',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Junior Agent', payment = 600 },
                  ['1'] = { name = 'Repossession Agent', payment = 800 },
                  ['2'] = { name = 'Senior Agent', payment = 1200 },
                  ['3'] = { name = 'Field Supervisor', payment = 1600 },
                  ['4'] = { name = 'Operations Manager', isboss = true, payment = 2000 }
            },
      },
      firefighter = {
            label = 'City Fire Department',
            type = 'firefighter',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Probationary Firefighter', payment = 850 },  -- Daily: 20,400
                  ['1'] = { name = 'Firefighter', payment = 1100 },              -- Daily: 26,400
                  ['2'] = { name = 'Senior Firefighter', payment = 1500 },       -- Daily: 36,000
                  ['3'] = { name = 'Lieutenant', payment = 1800 },               -- Daily: 43,200
                  ['4'] = { name = 'Captain', payment = 2000 },                  -- Daily: 48,000
                  ['5'] = { name = 'Battalion Chief', payment = 2200 },          -- Daily: 52,800
                  ['6'] = { name = 'Deputy Fire Chief', payment = 2400 },        -- Daily: 57,600
                  ['7'] = { name = 'Fire Chief', isboss = true, payment = 2500 } -- Daily: 60,000
            },
      },
      mechanic = {
            label = 'Mosley Auto Service',
            type = 'mechanic',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Apprentice Mechanic', payment = 850 },                -- Daily: 20,400
                  ['1'] = { name = 'Junior Mechanic', payment = 1100 },                   -- Daily: 26,400
                  ['2'] = { name = 'Mechanic', payment = 1500 },                          -- Daily: 36,000
                  ['3'] = { name = 'Senior Mechanic', payment = 1800 },                   -- Daily: 43,200
                  ['4'] = { name = 'Lead Mechanic', payment = 2000 },                     -- Daily: 48,000
                  ['5'] = { name = 'Workshop Supervisor', payment = 2200 },               -- Daily: 52,800
                  ['6'] = { name = 'Operations Manager', isboss = true, payment = 2250 }, -- Daily: 57,600
                  ['7'] = { name = 'Head Mechanic', isboss = true, payment = 2300 }       -- Daily: 57,600
            },
      },
      mechanic1 = {
            label = 'Route 68 Mechanics',
            type = 'mechanic',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Apprentice Mechanic', payment = 850 },                -- Daily: 20,400
                  ['1'] = { name = 'Junior Mechanic', payment = 1100 },                   -- Daily: 26,400
                  ['2'] = { name = 'Mechanic', payment = 1500 },                          -- Daily: 36,000
                  ['3'] = { name = 'Senior Mechanic', payment = 1800 },                   -- Daily: 43,200
                  ['4'] = { name = 'Lead Mechanic', payment = 2000 },                     -- Daily: 48,000
                  ['5'] = { name = 'Workshop Supervisor', payment = 2200 },               -- Daily: 52,800
                  ['6'] = { name = 'Operations Manager', isboss = true, payment = 2250 }, -- Daily: 57,600
                  ['7'] = { name = 'Head Mechanic', isboss = true, payment = 2300 }       -- Daily: 57,600
            },
      },
      mechanic2 = {
            label = 'Moto Club Service',
            type = 'mechanic',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Apprentice Mechanic', payment = 850 },                -- Daily: 20,400
                  ['1'] = { name = 'Junior Mechanic', payment = 1100 },                   -- Daily: 26,400
                  ['2'] = { name = 'Mechanic', payment = 1500 },                          -- Daily: 36,000
                  ['3'] = { name = 'Senior Mechanic', payment = 1800 },                   -- Daily: 43,200
                  ['4'] = { name = 'Lead Mechanic', payment = 2000 },                     -- Daily: 48,000
                  ['5'] = { name = 'Workshop Supervisor', payment = 2200 },               -- Daily: 52,800
                  ['6'] = { name = 'Operations Manager', isboss = true, payment = 2250 }, -- Daily: 57,600
                  ['7'] = { name = 'Head Mechanic', isboss = true, payment = 2300 }       -- Daily: 57,600
            },
      },
      realestate = {
            label = 'City Real Estate',
            type = 'realestate',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Real Estate Agent', payment = 1500 },                 -- Daily: 36,000
                  ['1'] = { name = 'Senior Agent', payment = 2000 },                      -- Daily: 48,000
                  ['2'] = { name = 'Real Estate Manager', isboss = true, payment = 2400 } -- Daily: 57,600
            },
      },
      bakery = {
            label = 'Bakery',
            type = 'bakery',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Trainee Baker', payment = 850 },                 -- Daily: 20,400
                  ['1'] = { name = 'Baker', payment = 1300 },                        -- Daily: 31,200
                  ['2'] = { name = 'Senior Baker', payment = 1600 },                 -- Daily: 38,400
                  ['3'] = { name = 'Head Baker', payment = 1800 },                   -- Daily: 43,200
                  ['4'] = { name = 'Bakery Manager', isboss = true, payment = 1900 } -- Daily: 45,600
            },
      },
      autoparts = {
            label = 'Los Santos Auto Parts',
            type = 'autoparts',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Assistant', payment = 150 },           -- Daily:
                  ['1'] = { name = 'Worker', payment = 250 },              -- Daily:
                  ['2'] = { name = 'Owner', isboss = true, payment = 500 } -- Daily:
            },
      },
      burgershot = {
            label = 'Burger Shot',
            type = 'burgershot',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Trainee Cook', payment = 850 },                       -- Daily: 20,400
                  ['1'] = { name = 'Cook', payment = 1300 },                              -- Daily: 31,200
                  ['2'] = { name = 'Senior Cook', payment = 1600 },                       -- Daily: 38,400
                  ['3'] = { name = 'Shift Supervisor', payment = 1800 },                  -- Daily: 43,200
                  ['4'] = { name = 'Burger Shot Manager', isboss = true, payment = 1900 } -- Daily: 45,600
            },
      },
      pizzathis = {
            label = 'Pizza This',
            type = 'pizzathis',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Pizza Trainee', payment = 850 },                     -- Daily: 20,400
                  ['1'] = { name = 'Pizza Maker', payment = 1300 },                      -- Daily: 31,200
                  ['2'] = { name = 'Senior Pizza Chef', payment = 1600 },                -- Daily: 38,400
                  ['3'] = { name = 'Kitchen Supervisor', payment = 1800 },               -- Daily: 43,200
                  ['4'] = { name = 'Pizza This Manager', isboss = true, payment = 1900 } -- Daily: 45,600
            },
      },
      catcafe = {
            label = 'Cat Cafe',
            type = 'catcafe',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Trainee Barista', payment = 850 },                 -- Daily: 20,400
                  ['1'] = { name = 'Barista', payment = 1300 },                        -- Daily: 31,200
                  ['2'] = { name = 'Senior Barista', payment = 1600 },                 -- Daily: 38,400
                  ['3'] = { name = 'Shift Lead', payment = 1800 },                     -- Daily: 43,200
                  ['4'] = { name = 'Cat Cafe Manager', isboss = true, payment = 1900 } -- Daily: 45,600
            },
      },
      kebabshop = {
            label = 'Kebab Shop',
            type = 'kebabshop',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Trainee Kebab Chef', payment = 0 },               -- Daily: 20,400
                  ['1'] = { name = 'Kebab Chef', payment = 0 },                       -- Daily: 31,200
                  ['2'] = { name = 'Senior Kebab Chef', payment = 0 },                -- Daily: 38,400
                  ['3'] = { name = 'Kitchen Lead', payment = 0 },                     -- Daily: 43,200
                  ['4'] = { name = 'Kebab Shop Manager', isboss = true, payment = 0 } -- Daily: 45,600
            },
      },
      club77 = {
            label = 'Club 77',
            type = 'club77',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Junior Bartender', payment = 1000 },           -- Daily: 24,000
                  ['1'] = { name = 'Bartender', payment = 1400 },                  -- Daily: 33,600
                  ['2'] = { name = 'Senior Bartender', payment = 1700 },           -- Daily: 40,800
                  ['3'] = { name = 'Bar Supervisor', payment = 1900 },             -- Daily: 45,600
                  ['4'] = { name = 'Club Manager', isboss = true, payment = 2000 } -- Daily: 48,000
            },
      },
      goldenpub = {
            label = 'Golden Pub',
            type = 'goldenpub',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Bar Assistant', payment = 1000 },             -- Daily: 24,000
                  ['1'] = { name = 'Bartender', payment = 1400 },                 -- Daily: 33,600
                  ['2'] = { name = 'Senior Bartender', payment = 1700 },          -- Daily: 40,800
                  ['3'] = { name = 'Bar Supervisor', payment = 1900 },            -- Daily: 45,600
                  ['4'] = { name = 'Pub Manager', isboss = true, payment = 2000 } -- Daily: 48,000
            },
      },
      tequilala = {
            label = 'Tequi La La',
            type = 'tequilala',
            defaultDuty = false,
            offDutyPay = false,
            grades = {
                  ['0'] = { name = 'Junior Bartender', payment = 1000 },          -- Daily: 24,000
                  ['1'] = { name = 'Bartender', payment = 1400 },                 -- Daily: 33,600
                  ['2'] = { name = 'Senior Bartender', payment = 1700 },          -- Daily: 40,800
                  ['3'] = { name = 'Bar Supervisor', payment = 1900 },            -- Daily: 45,600
                  ['4'] = { name = 'Pub Manager', isboss = true, payment = 2000 } -- Daily: 48,000
            },
      },
      tattoo = {
            label = 'Tattoo business',
            defaultDuty = true,
            offDutyPay = false,
            grades = {
                  ['0'] = {
                        name = 'novice',
                        payment = 50
                  },
                  ['1'] = {
                        name = 'artist',
                        payment = 50
                  },
                  ['2'] = {
                        name = 'boss',
                        payment = 50,
                        isboss = true
                  },
            },
      },

}
