
cwlVersion: v1.0
class: Workflow
    
requirements:
  MultipleInputFeatureRequirement: {}
inputs: []
# runCharmSimuFinish : output=Pythia8CharmSimuFinish/outDS
outputs:
  outDS:
    type: string
    outputSource: Pythia8CharmSimuFinish/outDS

steps:
  Pythia8CharmSimulation:
    run: prun
    in:
        opt_exec:
          default: "Pythia8CharmSimulation.sh  %RNDM:100000 >& _Pythia8CharmSimulation.log "
        opt_args:
          default: " --nJobs 10  --maxAttempt 3  --memory 8192  --outputs Pythia8CharmSimu.outDS.tar  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]

  runCharmSimuFinish:
    run: prun
    in:
        opt_inDS: Pythia8CharmSimu/outDS
        opt_inDsType:
          default: Pythia8CharmSimu.outDS.tar
        opt_exec:
          default: "runCharmSimuFinish.sh  %RNDM:100000 %IN >& _runCharmSimuFinish.log "
        opt_args:
          default: " --maxAttempt 3  --outputs Pythia8CharmSimuFinish.outDS.txt  --nFilesPerJob=1 --forceStaged  --site BNL_OSG_SPHENIX --avoidVP --noBuild "
    out: [outDS]
