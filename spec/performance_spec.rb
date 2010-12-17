require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'benchmark'

describe "Preformance" do

  it "should search in a reasonable time" do
    text    = 'a'*10000 + " IñTëRNâTIôNàLIZæTIøN is âWëSøMæ " + 'b'*10000
    snippet = ExcerptFu.new(text)

    # calculating the snippet was only around 0.089/0.090 seconds before the optimization.
    # Even though this is still really fast, it created a noticible lag when rendering pages
    # with many of those long snippets. The optimized version does this in under 0.02 seconds (usually around 0.018) --R
    benchmark = Benchmark.realtime { snippet.search("is", :limit => 14) }
    
    benchmark.should < 0.02
  end

  if ExcerptFu.oniguruma?
    it "should be reasonable fast for specific descriptions" do
      text = "NURC Vacancy no. 12/2010 Page 1 of 7Vacancy AnnouncementVacancy 12/2010Principal Scientist (Information Fusion), NATO Grade A4NATO Undersea Research Centre, La Spezia, ItalyThe NATO Undersea Research Centre (NURC) seeks a qualified Principal Scientist (Information Fusion) within the Applied Research Department. NURC conducts a basic and applied research program that is dedicated to fulfilling NATO's Operational Requirements in the maritime environment and undersea domain with an interdisciplinary scientific complement of more than 40 scientists drawn from NATO member nations on a rotational basis. Unique in its international makeup, NURC maintains a strong reputation for bringing the best and brightest scientists in undersea disciplines together to solve future problems, and has been an international leader in underwater research for over fifty years. Technical support is provided by a permanent staff, trained in the related engineering disciplines. The Centre operates two of the finest research vessels in the world, the Alliance and the Leonardo. NURC is one of three research and technology organizations in NATO.This position is for the lead scientist in Information Fusion. This group conducts research in information and sensor fusion, knowledge management, and operational decision support. Scientists in the Information Fusion Group participate in multi-disciplinary research in response to various operational needs in Maritime Security and Port Protection, Anti-Submarine Warfare, Mine Countermeasures and other maritime operations. Current research interests in this area include:• Undersea surveillance (network-centric multistatic sonar tracking with bandwidth constraints),• Maritime surveillance (multi-sensor tracking of cooperative and non-cooperative targets with active sensors and transponder data; tracking with sparse temporal and spatial coverage),• Situational Awareness (fusion of physical sensor data with commercial and intelligence data),• Group tracking (pattern recognition; data mining and higher-level fusion to include reasoning over vessel intent),• Real time decision support to maritime operations (impact of oceanographic variability and uncertainty on decision making).In addition to the attached generic job description, the principal duties and qualifications are as follows:RESPONSIBILITIES:The principal duty is to lead and advance the centre’s research activities in the area of information fusion and decision support. The research focus is on high level decision making processes in maritime operations and developing and providing the tools for operators to make the best decisions in the face of uncertainty. Areas of interest include:• Multi-sensor, multi-source information fusion including fusion of physical sensor data with commercial and intelligence data for group tracking and pattern recognition;• Decision making and human judgment under uncertainty, time-pressure and stress• Human-machine interaction and shared responsibility• Fusion of expert decisions (man and/or machine) for a “better” decision;• Data mining and higher-level fusion to include reasoning over behavioral intent.The Principal Scientist (Information Fusion) will provide support to centre research projects in maritime security, anti-submarine warfare and environmental support that require the experience and participation of an information fusion scientist. This work will include data analysis and reporting, presentation of results to NATO bodies, scientific meetings and elsewhere, and the design, planning and execution of experiments.http://www.nurc.nato.intNURC Vacancy no. 12/2010 Page 2 of 7Additional duties include:• Work in close collaboration with the Department Head on the overall coordination of information fusion research activities within NURC.• Promote the NURC programme of work among other research, technical and military organizations.• Develop cooperative efforts and scientific proposals to perform joint research work among institutions.• Document the performed work in published reports, technical and scientific documentation in the centre, refereed scientific journals and external presentations.• Supervise and mentor scientists and other team members.• Research scientists will have the opportunity to propose and conduct individual research projects related to one of the above programs.ESSENTIAL QUALIFICATIONS:1. Masters degree in computer science, information management, operations research, marine sciences, physical sciences, engineering, human factors or a related field. A Ph.D. is desired. Commensurate experience will be considered in lieu of an advanced degree for a highly qualified candidate with particular abilities and skills of interest to the centre.2. Senior-level professional experience in the areas of information fusion, knowledge management, decision support, human factors or a related subject.3. Proven ability to plan and conduct field experiments as scientist in charge. Participation in a minimum of 5 field experiments is desired.4. Experience in organizing and leading technical projects. More than 5 years experience in planning, proposing and/or managing research programmes is desired5. A reputation as a leading scientist in the field as evidenced by a record of publications and technical reports and other accomplishments6. Excellent numerical modeling and data analysis skills are essential. Ability to perform scientific programming using standard software and operating systems such as UNIX, linux, matlab, c++, etc.7. Successful collaborative research with international seagoing organizations8. Experience (including education) conducting research in one or more of the following areas should be demonstrated in the application.A. Information fusionB. Human factors and Human Machine InterfaceC. Knowledge management and data miningD. Sensor fusionE. Decision makingPERSONAL ATTRIBUTES:Able to conduct applied scientific research, to produce novel ideas and a desire to contribute personally to the project work. Tact, perseverance, adaptability and good communications skills are essential. Individuals must be self motivating, and have the ability to work harmoniously with colleagues, and other staff both civilian and military and from private scientific or industrial organizations.CONTRACTThe attention of candidates is drawn to the fact that this is a research post in a scientific establishment therefore the successful candidate will be offered a definite duration contract not exceeding three years' duration which, subject to satisfactory performance and organizational requirements, may be renewed by mutual consent for further periods of up to two years.NURC offers a comprehensive benefits package including tax-free remuneration, 6 weeks annual vacation, life and medical insurance, a retirement plan, educational allowance for dependent children and paid travel to the home country for the member and family every two years.APPLICATION PROCEDUREQualified candidates must submit a curriculum vita and completed official NURC application form (available at http://www.nurc.nato.int/employment/app-form.rtf) indicating vacancy number and job title. A cover letter explaining how their experience and qualifications fit them to the specified requirements should also be included. Applications are to be submitted electronically to: recruitment@nurc.nato.int (the application form and supporting documents must be submitted as a single word document). Applications will be accepted until 28 October 2010.NURC Vacancy no. 12/2010 Page 3 of 7Notes for candidates: the candidature of NATO redundant staff will be considered and evaluated before any other candidature.Notes for NATO civilian personnel officers/human resources managers: if you have any qualified redundant staff of same grade, please advise NURC either by message or e-mail (recruitment@nurc.nato.int) no later than 14 October 2010.Remarks: only nationals of the 28 NATO member countries can apply for vacancies at NURC. The NATO member countries are: Albania, Belgium, Bulgaria, Canada, Croatia, Czech Republic, Denmark, Estonia, France, Germany, Greece, Hungary, Iceland, Italy, Latvia, Lithuania, Luxembourg, Norway, Poland, Portugal, Romania, Slovakia, Slovenia, Spain, the Netherlands, Turkey, United Kingdom, and United States.POC: Human Resources Branch (recruitment@nurc.nato.int)Attachment: NATO Job Description TRC RAX 0120NURC Vacancy no. 12/2010 Page 4 of 7NATO JOB DESCRIPTIONPART I - JOB IDENTIFICATIONJob TitleScientistDate 13 Jan 2009TRC RAX 0120PE Post NumberAllied Command TransformationCommandA-4Rank/GradeNATO Undersea Research Centre ISPEHQNationalityResearch DivisionDivisionServiceApplied Research DepartmentBranch520A/525KJob CodeLa Spezia (ITA)Duty LocationPART II - PE DETAILSA. POST CONTEXTThe NATO Undersea Research Centre (NURC) develops technology that will facilitate the transformation of NATO military capabilities and is a focus for partnering in maritime innovation for NATO Commands and the NATO Nations. The Research Division is comprised of the Applied Research and Sytems Technology Departments and supported by Programme Management. The Centre’s Programme of Work is conducted in these two scientific departments oriented respectively toward systems research and physical processes research. -B. REPORTS TOScientist, TRC RAX 0010.C. PRINCIPAL DUTIESThe incumbent’s duties are:Principal Scientists may be assigned as Programme Managers, Team Leaders and/or perform individual research. The incumbent’s duties are:1. Programme Manager.a. Develop, articulate and defend the Centre’s Master Plan for the Thrust Area.b. The oversight and management of Thrust Area programme and project planning including supervision and mentoring of assigned staff.c. The overall execution of the Thrust Area Plans including:(1) Trade-offs among performance, schedules and costs.(2) Tracking, managing and reporting risks (technical, resource, other).(3) Timely delivery of outputs.(4) Documentation and reporting on activities and outputs.d. Conduct market surveys to identify new business opportunities and propose project to exploit the Centre’s technology base.e. Survey national research, technology, and development programmes for indications of future R&T directions in order to anticipate national acquisition trends and developments of interest to the Centre.f. Develop and implement strategies to actively engage other NATO bodies, agencies, and commands in the Centre’s programme.2. Team Leader.a. Technical leadership and direction for the Group and technical consultation for other groups and Programme Managers.b. Management of the Group including supervision and mentoring of staff.c. Advice and support to the multiyear Thrust Area Master Plan for the Programme of Work and the development of corresponding plans for the assigned components including resources.d. Direction, control and coordination of activities within his/her Group in implementing the Programme of Work.e. Monitors the activities of the group on support of Centre projects.Printed: 08/10/2009 11:00:55ECR Details VerifiedNURC Vacancy no. 12/2010 Page 5 of 7f. Advising the Department Head on issues related to the Group area of expertise.3. Individual Research.a. The investigation of maritime research problems either as an individual scientist working essentially on his/her own or as the leader of a small team.b. Carrying out and documenting experimental or theoretical investigations as part of a team working on maritime research problems assigned to it in implementation of the Programme of Work.c. Conception, design and development of advance equipment, demonstrators, or facilities.The following duties are required of all members of the grade:1. In the light of the experience expected in this grade, the provision of guidance and instruction to other members of the scientific and technical staff who may be assigned to him/her.2. Promoting and maintaining close relations with other scientists or military staff concerned with similar or related problems within the NURC and in national or international scientific establishments and military headquarters.3. Keeping himself/herself and the directorate informed about NATO activities in the various member countries that are relevant to the current and future activities of the NURC and to the exploitation of NURC products and knowledge.4. Interaction with national and international scientific establishments in order to remain abreast of the latest technical and scientific principles and practices on matters pertaining to his/her component of the Programme of Work as well as potential exploratory research areas and technology watch activities.Legal authority is held: NoneBudget authority is held: NoneDecision authority is held: NoneThere are no first line reporting responsibilities.D. ADDITIONAL DUTIES1. The incumbent may be required to perform his or her duties onboard NURC’s vessels and may be called upon to perform like duties elsewhere in the organisation.2. Flexibility Clause: In order for the command to deal with emergent requirements, the incumbent may be required to perform other related duties as directed (in particular, the incumbent can expect to work as a member of Working Groups, Project Teams, etc. for defined periods of time). Additionally, the incumbent may also be reassigned as directed by the Deputy Director for up to 180 days (and where necessary in excess of 180 days with the agreement of the incumbent).3. Annual TDY Requirement: The incumbent can expect to go on TDY both within and outside NATO’s boundaries.The employee may be required to perform a similar range of duties elsewhere within the organisation at the same grade without there being any change to the contractPART III – QUALIFICATIONSA. ESSENTIAL QUALIFICATIONS1. Professional/ExperiencePrimary: 520A Engineering and engineering tradesThe study of engineering and engineering trades without specialising in any of the detailed fields. (specialisation: Engineering (broad programmes)) [Ref: UNESCO ISCED 1997:520]Primary Skill Level: Initiate or influence: Has defined authority and responsibility for all aspects of a significant work area, including functional, financial and quality aspects. Establishes organisational objectives, delegates assignments and is accountable for actions taken by self and subordinates. Influences policy formation on contribution of specialisation to operational or transformational objectives. Executes leadership and influences and persuades subordinates, peers and external organisations, HQs and agencies. Decisions impact the functional area of the enterprise, achievement of organisational objectives and financial performance. Work involves creative application of specialist and/or management principles. Develops highNURC Vacancy no. 12/2010 Page 6 of 7level relationships with external organisations, HQs and agencies. Influences internally and externally at senior management level. Executes highly complex work activities covering, technical, financial and quality aspects and contributing to formulation of the strategy and policies of the functional area. Able to absorb complex technical information and communicate effectively at all levels to both specialist and non-specialist audiences. Responsible to assess and evaluate risks and to understand the implications of new concepts, technologies and trends. Has a broad understanding of the enterprise and deep understanding of the functional areas. Responsible to keep skills within the assigned functional area up to date and to maintain awareness of developments in the wider area of enterprise activities. [Ref: NATO adaptation of SFIA v3 2005:Generic Level Description]a. 4 years post-graduate experience in research related to the maritime environment, systems or operations.b. Demonstrated leadership ability and experience in the management of research efforts.c. Recognized achievement in research.d. A more specific statement of required education and training may be developed at the time of recruitment in order to address the specific needs of the Programme of Work.Secondary: 525K Motor vehicles, ships and aircraftThe study of designing, developing, producing, maintaining, diagnosing faults in, repairing and servicing motor vehicles, including earth moving equipment and agriculture machines. Typical is the combining of studies in both metal structures and motors. (specialisation: Maritime engineering) [Ref: UNESCO ISCED 1997:525]Secondary Skill Level: Initiate or influence: Has defined authority and responsibility for all aspects of a significant work area, including functional, financial and quality aspects. Establishes organisational objectives, delegates assignments and is accountable for actions taken by self and subordinates. Influences policy formation on contribution of specialisation to operational or transformational objectives. Executes leadership and influences and persuades subordinates, peers and external organisations, HQs and agencies. Decisions impact the functional area of the enterprise, achievement of organisational objectives and financial performance. Work involves creative application of specialist and/or management principles. Develops high level relationships with external organisations, HQs and agencies. Influences internally and externally at senior management level. Executes highly complex work activities covering, technical, financial and quality aspects and contributing to formulation of the strategy and policies of the functional area. Able to absorb complex technical information and communicate effectively at all levels to both specialist and non-specialist audiences. Responsible to assess and evaluate risks and to understand the implications of new concepts, technologies and trends. Has a broad understanding of the enterprise and deep understanding of the functional areas. Responsible to keep skills within the assigned functional area up to date and to maintain awareness of developments in the wider area of enterprise activities. [Ref: NATO adaptation of SFIA v3 2005:Generic Level Description]None2. Education/TrainingMasters Degree or equivalent in maritime, marine, mechanical engineering, or naval engineering, engineering or related discipline and 4 years post related experience3. Security ClearanceNATO SECRET4. LanguageEnglish SLP 3333 (Listening, Speaking, Reading and Writing)NOTE: The work both oral and written in this post and in this Headquarters as a whole is conducted mainly in English.5. Standard Automatic Data Processing KnowledgeWord Processing:Working KnowledgeSpreadsheet:Working KnowledgeGraphics Presentation:Working KnowledgeNURC Vacancy no. 12/2010 Page 7 of 7Database:Working KnowledgeeMail Clients/Web Browsers:Working KnowledgeWeb Content Management:Basic KnowledgeB. DESIRABLE QUALIFICATIONS1. Professional/ExperienceSpecific Experience: a. Capability to maintain professional qualifications through continued education to remain abreast of the latest technical and scientific principles and practices.b. Experience with the ISO 9000 or similar Quality Management System.c. Experience in an international organisation.2. Education/TrainingDoctorate (PhD)3. LanguageEnglish 4444C. CIVILIAN POSTS1. Personal AttributesThe incumbent must be highly articulate and persuasive possessing tact and diplomacy. He/She must have a proven ability to work with no supervision and is expected to be a proactive self-starter. Must possess keen perception and apply sound judgement, which must take due account of political realities. Frequent requirement for original thought. The incumbent must be capable of working in a demanding environment, be clear, concise, and convincing in written and oral presentations, and flexible in response to changing requirements. He/She must also have:- Proven ability to work successfully with military staff.- Demonstrated leadership and management capabilities.- Personal qualities of tact, judgement and adaptability.- Ability to tactfully and effectively interface with senior management personnel, peers, and subordinates.- Good political awareness and motivational and listening skills.- A sense of diplomacy and propriety in order to work harmoniously with colleagues and other staff, both civilian and military, as well as with staff from private scientific/industrial organisations.2. Managerial ResponsibilitiesSupervision of a Group. Heads a unit, which involves the direction, planning and coordination of diverse subjects. This work involves projects and programmes which engage multiple parts of the organisation and often involves interaction with external organisations.3. Professional ContactsOften involved in significant discussions at senior committee level with representatives of NATO nations or other NATO bodies on behalf of the NURC. Has a regular professional contact typically at senior management level inside and outside the Centre. Develops policy and processes which requiring explanation, discussion, persuasion and approval of actions. Requires good negotiating skill, tact and persuasion.4. Contribution to the ObjectivesProvides leadership in several key aspects of the performance of the Programme of Work. Acts as a group leader for a group of scientists organised by disciplines and as a senior researcher.5. Work EnvironmentThe work is normally performed in a typical Office environment. Normal Working Conditions apply. The risk of injury is categorised as: No Risk"
      substring = "NURC - NATO Undersea Research Centre"
      snippet = ExcerptFu.new(text)

      # before: ~ 0.225/0.228 seconds
      # with Oniguruma gem: around 0.07 seconds --R
      benchmark = Benchmark.realtime { snippet.search(substring, :limit => 200) }
      
      benchmark.should < 0.07
    end
  else
    puts 'skipping test for oniguruma optimization'
  end
end
