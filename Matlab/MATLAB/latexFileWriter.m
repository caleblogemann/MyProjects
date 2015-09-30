classdef latexFileWriter < handle
    %LATEXFILEWRITER Utilities to print LaTeX to files
    %   Detailed explanation goes here

    properties(Access = private)
        fileID
        nTabs
    end

    methods
        function obj = latexFileWriter(filename)
            p = inputParser;
            addRequired(p, 'filename', @ischar);
            parse(p, filename);

            if(isempty(strfind(filename, '.tex')))
                obj.fileID = fopen(strcat(filename,'.tex'), 'w');
            else
                obj.fileID = fopen(filename, 'w');
            end

            obj.nTabs = 1;
        end

        function delete(latexFileWriter)
            fclose(latexFileWriter.fileID);
        end

        function [] = print(obj, textToPrint)
            p = inputParser;
            p.addRequired('obj', @(x) isa(x, 'latexFileWriter'));
            p.addRequired('textToPrint', @ischar);
            p.parse(obj, textToPrint);

            fprintf(obj.fileID, latexFileWriter.formatString(textToPrint));
        end

        function [] = printHeader(obj, varargin)
            p = inputParser;
            addRequired(p, 'obj', @(x) isa(x, 'latexFileWriter'));
            addParameter(p, 'isLandscape', true, @islogical);
            parse(p, obj, varargin{:});

            obj.print('\documentclass[10pt]{article}');
            obj.print('\usepackage{graphicx}');
            if(p.Results.isLandscape)
                fprintf(obj.fileID, latexFileWriter.formatString('\usepackage[margin=0.5in, landscape]{geometry}'));
            else
                fprintf(obj.fileID, latexFileWriter.formatString('\usepackage[margin=0.5in]{geometry}'));
            end
            fprintf(obj.fileID, latexFileWriter.formatString('\usepackage{booktabs}'));
            fprintf(obj.fileID, latexFileWriter.formatString('\begin{document}'));
        end

        function [] = printSectionHeader(obj, sectionName)
            string = strcat('\section*{', sectionName, '}');
            fprintf(obj.fileID, latexFileWriter.formatString(string));
        end

        function [] = printBeginCenter(obj)
            fprintf(obj.fileID,...
                latexFileWriter.formatString('\begin{center}'));
            obj.nTabs = obj.nTabs + 1;
        end

        function [] = printEndCenter(obj)
            fprintf(obj.fileID,...
                latexFileWriter.formatString('\end{center}'));
            obj.nTabs = obj.nTabs - 1;
        end

        function [] = printImage(obj, imageName, varargin)
            p = inputParser;
            addRequired(p, 'obj', @(x) isa(x, 'latexFileWriter'));
            addRequired(p, 'imageName', @ischar);
            addParameter(p, 'Options', '', @ischar);
            parse(p, obj, imageName, varargin{:});

            string = strcat('\includegraphics[', p.Results.Options, ']{',...
                imageName, '}');
            fprintf(obj.fileID, latexFileWriter.formatString(string,...
                'NumberOfTabs', obj.nTabs));
        end

        function [] = printTable(obj, columnLabels, dataSet)
            p = inputParser;
            addRequired(p, 'fileHandle', @isnumeric);
            addRequired(p, 'columnLabels', @ischar);
            % TODO: add check that data set is same size as columnLabels
            addRequired(p, 'dataSet', @isnumeric);
            parse(p, obj, columnLabels, dataSet);


        end

        function [] = printEndDocument(obj)
            fprintf(obj.fileID, latexFileWriter.formatString('\end{document}', ...
                'NumberOfTabs', obj.nTabs));
        end
    end

    methods(Static)
        function [ output ] = formatString(input, varargin)
            p = inputParser;
            addRequired(p, 'input', @ischar);
            addParameter(p, 'NumberOfTabs', 0, @isnumeric);
            parse(p, input);

            output = strrep(input, '\', '\\');

            % add tabs and end of line
            for i = 1:p.Results.NumberOfTabs
                output = strcat('\t', output);
            end
            output = strcat(output, '\n');
        end

        function [ output ] = printMatrix(input)
            output = sprintf('\\begin{bmatrix}\n');
            [nRows, nCols] = size(input);
            for i=1:nRows
                output = sprintf('%s    ', output);
                for j=1:nCols
                    output = sprintf('%s%s', output, num2str(input(i, j)));
                    if(j < nCols)
                        output = sprintf('%s & ', output);
                    end
                end
                if(i < nRows)
                    output = sprintf('%s \\\\\n', output);
                else
                    output = sprintf('%s \n', output);
                end
            end
            output = sprintf('%s\\end{bmatrix}\n', output);
        end
    end
end

