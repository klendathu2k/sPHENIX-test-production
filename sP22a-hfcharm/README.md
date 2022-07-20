## SHREK Inputs
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/pythia8-charm-simulation-full/mergeOutputs.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/pythia8-charm-simulation-full/runCalorimeter.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/pythia8-charm-simulation-full/runCharmSimu.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/pythia8-charm-simulation-full/runMinbSimu.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/pythia8-charm-simulation-full/runPass3Track.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/pythia8-charm-simulation-full/runPass4Track.yaml
- /direct/sphenix+u/jwebb2/work/2022/SHREK/shrek/tests/pythia8-charm-simulation-full/runPileup.yaml
## Generated scripts
- mergeOutputs.sh
- Pythia8Calorimeter.sh
- Pythia8CharmSimulation.sh
- Pythia8MinbSimulation.sh
- Pythia8Pass3Track.sh
- Pythia8Pass4Track.sh
- Pythia8CharmPileup.sh
## Job resources
- /direct/sphenix+u/jwebb2/work/2022/SHREK/MDC2/submit/HF_pp200_signal/pass2/rundir/Fun4All_G4_Pileup_pp.C
- /direct/sphenix+u/jwebb2/work/2022/SHREK/MDC2/submit/HF_pp200_signal/pass2/rundir/G4_OutputManager_Pileup_pp.C
- /direct/sphenix+u/jwebb2/work/2022/SHREK/MDC2/submit/HF_pp200_signal/pass2/rundir/copyscript.pl
- /direct/sphenix+u/jwebb2/work/2022/SHREK/MDC2/submit/HF_pp200_signal/pass2/rundir/getinputfiles.pl
- /direct/sphenix+u/jwebb2/work/2022/SHREK/MDC2/submit/HF_pp200_signal/pass2/rundir/run_pileup.sh
## Job dependencies
![Workflow graph](workflow.png)
- mergeOutputs
  inputs:
  - Pythia8Calorimeter/outDS
  - Pythia8Pass4Track/outDS

  outputs:
  - Pythia8CharmOutput/outDS
- Pythia8Calorimeter
  inputs:
  - Pythia8CharmPileup/outDS

  outputs:
  - Pythia8Calorimeter/outDS
- Pythia8CharmSimulation

  outputs:
  - Pythia8CharmSimulation/outDS
- Pythia8MinbSimulation

  outputs:
  - Pythia8MinbSimulation/outDS
- Pythia8Pass3Track
  inputs:
  - Pythia8CharmPileup/outDS

  outputs:
  - Pythia8Pass3Track/outDS
- Pythia8Pass4Track
  inputs:
  - Pythia8Pass3Track/outDS

  outputs:
  - Pythia8Pass4Track/outDS
- Pythia8CharmPileup
  inputs:
  - Pythia8CharmSimulation/outDS
  - Pythia8MinbSimulation/outDS

  outputs:
  - Pythia8CharmPileup/outDS
## PanDA Monitoring
[panda monitoring](https://panda-doma.cern.ch/tasks/?taskname=user.jwebb2.sP22a-hfcharm-81c639f5-085b-11ed-9786-00163e101049_*)
