
cwlVersion: v1.0
class: Workflow
    
requirements:
  MultipleInputFeatureRequirement: {}
# Pythia8CharmPileup : input=Pythia8CharmSignal
# Pythia8CharmPileup : input=Pythia8Background
inputs:
  Pythia8CharmSignal: string
  Pythia8Background: string

# mergeOutputs : output=Pythia8CharmOutput/outDS
outputs:
  outDS:
    type: string
    outputSource: Pythia8CharmOutput/outDS

steps:
  Pythia8CharmPileup:
    run: prun
    in:
        opt_inDS: Pythia8CharmSignal
        opt_inDsType:
          default: Pythia8CharmSimulation.outDS.tar
        opt_secondaryDSs: [Pythia8Background]
        opt_secondaryDsTypes:
          default: [Pythia8MinbSimulation.outDS.tar]
        opt_exec:
          default: "Pythia8CharmPileup.sh  %RNDM:200000 %IN %IN2 >& _Pythia8CharmPileup.log "
        opt_args:
          default: " --nJobs 10  --maxAttempt 5  --memory 8192  --outputs Pythia8Pileup.outDS.tar  --nFilesPerJob=1 --secondaryDSs IN2:5:%{DS1} --forceStaged  --forceStagedSecondary  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  Pythia8Pass3Track:
    run: prun
    in:
        opt_inDS: Pythia8CharmPileup/outDS
        opt_inDsType:
          default: Pythia8Pileup.outDS.tar
        opt_exec:
          default: "Pythia8Pass3Track.sh  %RNDM:200000 %IN >& _Pythia8Pass3Track.log "
        opt_args:
          default: " --maxAttempt 3  --outputs Pythia8Pass3Track.outDS.tar  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  Pythia8Calorimeter:
    run: prun
    in:
        opt_inDS: Pythia8CharmPileup/outDS
        opt_inDsType:
          default: Pythia8Pileup.outDS.tar
        opt_exec:
          default: "Pythia8Calorimeter.sh  %RNDM:200000 %IN >& _Pythia8Calorimeter.log "
        opt_args:
          default: " --maxAttempt 3  --outputs Pythia8Calorimeter.outDS.tar  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  Pythia8Pass4Track:
    run: prun
    in:
        opt_inDS: Pythia8Pass3Track/outDS
        opt_inDsType:
          default: Pythia8Pass3Track.outDS.tar
        opt_exec:
          default: "Pythia8Pass4Track.sh  %RNDM:200000 %IN >& _Pythia8Pass4Track.log "
        opt_args:
          default: " --maxAttempt 3  --outputs Pythia8Pass4Track.outDS.tar  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  mergeOutputs:
    run: prun
    in:
        opt_inDS: Pythia8Calorimeter/outDS
        opt_inDsType:
          default: Pythia8Calorimeter.outDS.tar
        opt_secondaryDSs: [Pythia8Pass4Track/outDS]
        opt_secondaryDsTypes:
          default: [Pythia8Pass4Track.outDS.tar]
        opt_exec:
          default: "mergeOutputs.sh  %RNDM:200000 %IN %IN2 >& _mergeOutputs.log "
        opt_args:
          default: " --maxAttempt 3  --outputs Pythia8CharmOutput.outDS.tar  --nFilesPerJob=1 --secondaryDSs IN2:1:%{DS1} --forceStaged  --forceStagedSecondary  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]
