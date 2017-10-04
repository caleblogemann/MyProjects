#include "ToDo.h"

ToDo::ToDo(){
}

ToDo::~ToDo(){
}

size_t ToDo::size() const {
    return m_tasks.size();
}

void ToDo::addTask(const std::string& task){
    m_tasks.push_back(task);
}

std::string ToDo::getTask(size_t index) const {
    if (index < m_tasks.size()) {
        return m_tasks[index];
    } else {
        return "";
    }
}
