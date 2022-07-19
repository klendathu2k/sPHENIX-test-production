
cwlVersion: v1.0
class: Workflow
    
requirements:
  MultipleInputFeatureRequirement: {}
inputs: []
# Pythia8Pass3Track : output=Pythia8Pass3Track/outDS
outputs:
  outDS:
    type: string
    outputSource: Pythia8Pass3Track/outDS

steps:
  Pythia8CharmSimulation:
    run: prun
    in:
        opt_exec:
          default: "Pythia8CharmSimulation.sh  %RNDM:700 >& _Pythia8CharmSimulation.log "
        opt_args:
          default: " --nJobs 1  --maxAttempt 3  --outputs Pythia8CharmSimulation.outDS.tar  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  Pythia8MinbSimulation:
    run: prun
    in:
        opt_exec:
          default: "Pythia8MinbSimulation.sh  %RNDM:700 >& _Pythia8MinbSimulation.log "
        opt_args:
          default: " --nJobs 5  --maxAttempt 3  --outputs Pythia8MinbSimulation.outDS.tar  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  Pythia8CharmPileup:
    run: prun
    in:
        opt_inDS: Pythia8CharmSimulation/outDS
        opt_inDsType:
          default: Pythia8CharmSimulation.outDS.tar
        opt_secondaryDSs: [Pythia8MinbSimulation/outDS]
        opt_secondaryDsTypes:
          default: [Pythia8MinbSimulation.outDS.tar]
        opt_exec:
          default: "Pythia8CharmPileup.sh  %RNDM:700 %IN %IN2 >& _Pythia8CharmPileup.log "
        opt_args:
          default: " --maxAttempt 3  --outputs Pythia8Pileup.outDS.tar  --nFilesPerJob=1 --secondaryDSs IN2:5:%{DS1} --forceStaged  --forceStagedSecondary  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  Pythia8Pass3Track:
    run: prun
    in:
        opt_inDS: Pythia8CharmPileup/outDS
        opt_inDsType:
          default: Pythia8Pileup.outDS.tar
        opt_exec:
          default: "Pythia8Pass3Track.sh  %RNDM:700 %IN >& _Pythia8Pass3Track.log "
        opt_args:
          default: " --maxAttempt 3  --outputs Pythia8Pass3Track.outDS.tar  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]
