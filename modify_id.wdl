task modify_columns {
    input {
        File input_file
    }

    command {
        python <<EOF
import pandas as pd

# Read the input file
df = pd.read_csv('${input_file}', sep='\\t')

# Create the new FID_IID column
df['FID_IID'] = df['FID'].astype(str) + '_' + df['IID'].astype(str)

# Select and rename columns
df = df[['FID_IID', 'FID_IID', 'FA', 'MO', 'SEX', 'STATUS']]
df.columns = ['FID', 'IID', 'FA', 'MO', 'SEX', 'STATUS']

# Save the output file
df.to_csv('output_file.txt', sep='\\t', index=False)
EOF
    }

    output {
        File output_file = 'output_file.txt'
    }

    runtime {
        docker: "python:3.8"
    }
}

workflow modify_columns_workflow {
    input {
        File input_file
    }

    call modify_columns {
        input:
            input_file = input_file
    }

    output {
        File output_file = modify_columns.output_file
    }
}
